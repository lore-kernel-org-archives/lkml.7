Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F5F20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuMSKRWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfJVNoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:44:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731707AbfJVNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571751838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=zHfL5vClgCqy3xfsuPRygxfVvqfz2goIqbC4zkAjqZY=;
        b=OuMSKRWwCxsa+Ue4CZQyeI2kAZXy/pnPOwWlGjkSqKOfqk9K5cpl+ugi5niikCXE63iJzQ
        XTVVYr/22CfJ7p9FSJ3GBwGn/57vJ/MyC3epDzVQED8Sv/4VSz37UO8vjuwwMOiAW0mz0u
        XpgKZ0OIpdAcRZAbts/7l+umL6LafjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-I13NcTyKPKiRhLkpj3_Img-1; Tue, 22 Oct 2019 09:43:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF0D5ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:43:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1FD51059A53
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:43:54 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A7C8218089DC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:43:54 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:43:54 -0400 (EDT)
From:   Dave Anderson <anderson@redhat.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1789830883.7797936.1571751834645.JavaMail.zimbra@redhat.com>
In-Reply-To: <55902207.7797907.1571751831873.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
MIME-Version: 1.0
X-Originating-IP: [10.18.17.5, 10.4.195.9]
Thread-Topic: x86/kdump: always reserve the low 1MiB when the crashkernel option is specified
Thread-Index: 85xNxgPNoOZRUFlcGwROOLaIM4U0zw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: I13NcTyKPKiRhLkpj3_Img-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


---- Original Message -----

> >=20
> > [root linux]$ crash vmlinux
> > /var/crash/127.0.0.1-2019-09-19-08\:31\:27/vmcore
> > WARNING: kernel relocated [240MB]: patching 97110 gdb minimal_symbol va=
lues
> >=20
> >       KERNEL: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmlinux
> >     DUMPFILE: /var/crash/127.0.0.1-2019-09-19-08:31:27/vmcore  [PARTIAL=
 DUMP]
> >         CPUS: 128
> >         DATE: Thu Sep 19 08:31:18 2019
> >       UPTIME: 00:01:21
> > LOAD AVERAGE: 0.16, 0.07, 0.02
> >        TASKS: 1343
> >     NODENAME: amd-ethanol
> >      RELEASE: 5.3.0-rc7+
> >      VERSION: #4 SMP Thu Sep 19 08:14:00 EDT 2019
> >      MACHINE: x86_64  (2195 Mhz)
> >       MEMORY: 127.9 GB
> >        PANIC: "Kernel panic - not syncing: sysrq triggered crash"
> >          PID: 9789
> >      COMMAND: "bash"
> >         TASK: "ffff89711894ae80  [THREAD_INFO: ffff89711894ae80]"
> >          CPU: 83
> >        STATE: TASK_RUNNING (PANIC)
> >=20
> > crash> kmem -s|grep -i invalid
> > kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086a=
c099f0c5a4
> > kmem: dma-kmalloc-512: slab:ffffd77680001c00 invalid freepointer:a6086a=
c099f0c5a4
> > crash>
>=20
> I fail to see what that's trying to tell me? You have invalid pointers?

Correct, because the pointer values are encrypted.  The command is walking =
through the
singly-linked list of free objects in a slab from the dma-kmalloc-512 slab =
cache.  The
slab memory had been allocated from low memory, and because of the  problem=
 at hand,
it was was copied to the vmcore in its encrypted state.

Dave=20

