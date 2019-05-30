Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAEE25E7D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="gvl402Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE3R3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:29:52 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:45235 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3R3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:29:52 -0400
Date:   Thu, 30 May 2019 17:29:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1559237390;
        bh=M8YyTOkgVMTajh8KGkpA9X36l6Wgi1U0JaasE6Ezk6I=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=gvl402OznC1mp1iITEqh9zggYvtgCL+z3e21E5YcX89R3rsg7Li06WeOPFDdAJ2de
         FwafvUmYTKclEaBdM9X1IGFLvWQ5DzSiuBFmfdPkyM9m32Qu1CeDg+2oPLbDa+5VW8
         Aqy8shkOLp3kPTnD7mpCD+kcUmLzbl/U3SM/DEow=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   zvuln <zvuln@protonmail.com>
Reply-To: zvuln <zvuln@protonmail.com>
Subject: Question about mitigating Zombieload
Message-ID: <0YYNF4UDAi1NJOBtzDhwqt1FJ_3NzTYIvtu2ApVMMPsEH0cfm9OMgYJpVHd8w0pfmeQCScYO5x-PlvdbNnnERNKiYMhEw1z3hQPaFRwvVOM=@protonmail.com>
Feedback-ID: 349QC9di8fDcOs3pJ4oYTiFYdRqFoOjDYGmPCPnc1iXIhR0GW-SA3Emdze7698kkP1aBvTGF5giegN950lNFYA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the x86 architecture is once again
afflicted with a flaw that arises out of
unsafely implemented accelerations, namely
the just-releaved Zombieload vulnerability.

We know that Zombieload is possible when
Hyperthreading is enabled. Here is a question:

Is it possible to disable Hyperthreading
not for all cores in the BIOS but rather
on a per-core basis programmatically from
the OS or from the bootloader?

I ask because if this were possible, then
it would be reasonable to segregate the sensitive
code i.e. the kernel and the major daemons
into one core that has Hyperthreading enabled,
and then run all other (risky) user processes
on the other cores, which have Hyperthreading
disabled.

Cheers.

