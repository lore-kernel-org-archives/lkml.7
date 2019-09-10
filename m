Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE1CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BC92084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="afV9jy3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfIJNQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:16:52 -0400
Received: from ozlabs.org ([203.11.71.1]:43341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfIJNQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:16:52 -0400
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 46SQXw5LXpz9s7T;
        Tue, 10 Sep 2019 23:16:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1568121409;
        bh=8YpvriWgZotmerko0J+/vGDj0I0pWRFk35pz5gDDI3E=;
        h=Subject:From:To:Cc:Date:From;
        b=afV9jy3e43LDgZZ6cCx9zYoP1i33CBwatneHIcRpDM/dYSvl+PlNywbzT+32oG8bn
         fEMIvS/EcUUFmz95slyme9PkgMYgwoPxm0MXKvlhgOpBJTLx8yJ+fD9kBATXOj0sLi
         nG6HuBAKzF/cRbGWpr+PY+ZZjgLNPMuG903ctQ4DgFMuPgXxDt1fq1bFFHmpCcU6RY
         kg0D3PZkrvxrSW/O7PyFz9OOIHTq218qDKrHhGyJxJFRkeGORToHoddoe+bLFs1/eP
         MVgPofN8mI0/qQ2RmkZQupFHsoohFs5gTiHM6Y7yW3C1MGAvBppA731Z70wSer0/Xn
         4tyf33YQYzK8w==
Received: by neuling.org (Postfix, from userid 1000)
        id 9362C2A01E8; Tue, 10 Sep 2019 23:16:48 +1000 (AEST)
Message-ID: <856d6efa0e9b4dd39030e7372a17e3dba2db2aef.camel@neuling.org>
Subject: CVE-2019-15030: Linux kernel: powerpc: data leak with FP/VMX 
 triggerable by unavailable exception in transaction
From:   Michael Neuling <mikey@neuling.org>
To:     oss-security <oss-security@lists.openwall.com>
Cc:     Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Linuxppc-users <linuxppc-users@lists.ozlabs.org>,
        Gustavo Romero <gromero@linux.vnet.ibm.com>
Date:   Tue, 10 Sep 2019 23:16:48 +1000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel for powerpc since v4.12 has a bug in it's TM handling wher=
e any
user can read the FP/VMX registers of a difference user's process. Users of=
 TM +
FP/VMX can also experience corruption of their FP/VMX state.

To trigger the bug, a process starts a transaction and reads a FP/VMX regis=
ter.
This transaction can then fail which causes a rollback to the checkpointed
state. Due to the kernel taking an FP/VMX unavaliable exception inside a
transaction and the kernel's incorrect handling of this, the checkpointed s=
tate
can be set to the FP/VMX registers of another process. This checkpointed st=
ate
can then be read by the process hence leaking data from one process to anot=
her.

The trigger for this bug is an FP/VMX unavailable exception inside a
transaction, hence the process needs FP/VMX off when starting the transacti=
on.
FP/VMX availability is under the control of the kernel and is transparent t=
o the
user, hence the user has to retry the transaction many times to trigger thi=
s
bug.=20

All 64-bit machines where TM is present are affected. This includes all POW=
ER8
variants and POWER9 VMs under KVM or LPARs under PowerVM. POWER9 bare metal
doesn't support TM and hence is not affected.

The bug was introduced in commit:
  f48e91e87e67 ("powerpc/tm: Fix FP and VMX register corruption")
Which was originally merged in v4.12

The upstream fix is here:
  https://git.kernel.org/torvalds/c/8205d5d98ef7f155de211f5e2eb6ca03d95a5a6=
0

The fix can be verified by running the tm-poison from the kernel selftests.=
 This
test is in a patch here:
https://patchwork.ozlabs.org/patch/1157467/
which should eventually end up here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/testing/selftests/powerpc/tm/tm-poison.c

cheers
Mikey





