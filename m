Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0751C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2720645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X5ETGGaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfEBWgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:36:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37252 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:36:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so3742977edw.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wzidWzynEo/DXM93j3mYhduzzCvKaQ+YtgjP83dctao=;
        b=X5ETGGaJfQHGRUSnWQGIOq/DgYJrpmnwNLAnBCGvjMzs0IYe8H4k40vhnG0x0PtTXp
         sWQK2U+FmSPBGJ7GR24/JK9f/hCOJYyze5MUGSel6z7iEB2sqXVMPf6aTn86R4AaP5pn
         6FQEVIGwKuIcdbr4sts+qszeoBo6aIl94MXIXsfPMXP6bKsBgX72s1UofOvqOnoksME5
         Pe6MLS/OzDiGFJY2jo8fG3gHRVo3/NlsmLVP785V1Tu7GO8PNXBXjVIm7U0cXNqw9t+9
         Pj427ef28DFtRCbdaODf41bCvVkT1US/U8Mq5PyhZKAJJ46/wRGm0zL69PqfxQgIYKkB
         BZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wzidWzynEo/DXM93j3mYhduzzCvKaQ+YtgjP83dctao=;
        b=hq3zeIPcLVW8bCUsQcMTiFcyqCisOVqWaiolzorsbApGR2ZBm9tsZ1PbO5Knxh7VuO
         jjIcjrbATjmW6XykiX4tavmQsLzdRHn9TGsHhI3cTW1FyAI6BPQfFW5PFfapdBS6vc2Q
         RqfvpyiX75XO5cPV1q4grbjp9HD+ebbClD5/v4hpVI5bLnGfjI0zQ9BK2V29CBQdRs4S
         i6HJebvq3LIiZpbMHEcM/Y5ac7ML/Tp8YErW8mhhWBRNaZAgZSHVmjOYtzXUtvGRpUbO
         1BM4zaRgbTybnYls8Ktqs6WcY2fL1Q0E9Xos6pLF2y0ux1PWsQzoSDjFDduVYKSF5kyp
         FOiA==
X-Gm-Message-State: APjAAAW0WCURjqOo+mirCO6twFQhkY40ujmTlCeRV2cZKwTBtTwDT3dC
        9SHrAxz7VKSNG+EBpetNMBRgmgB7LpT89mR+Kaas3w==
X-Google-Smtp-Source: APXvYqzM3pTNRpb2+kI4mLKyKA2mBJRU32x6x6ySml+fIWvJtXTuJ/Ut8dgCtm/xHIYirHmupbd6Gt2T77m3feSDsdY=
X-Received: by 2002:a17:906:3154:: with SMTP id e20mr3210549eje.263.1556836571272;
 Thu, 02 May 2019 15:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
 <CA+CK2bA=E4zRFb0Qky=baOQi_LF4x4eu8KVdEkhPJo3wWr8dYQ@mail.gmail.com> <9bf70d80718d014601361f07813b68e20b089201.camel@intel.com>
In-Reply-To: <9bf70d80718d014601361f07813b68e20b089201.camel@intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 18:36:00 -0400
Message-ID: <CA+CK2bBRwFN342x3t77CBrFTrXUn3VMn6a-cf-y0fF+2DBYpbA@mail.gmail.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "sashal@kernel.org" <sashal@kernel.org>, "bp@suse.de" <bp@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 6:29 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Thu, 2019-05-02 at 17:44 -0400, Pavel Tatashin wrote:
>
> > > In running with these patches, and testing the offlining part, I ran
> > > into the following lockdep below.
> > >
> > > This is with just these three patches on top of -rc7.
> >
> > Hi Verma,
> >
> > Thank you for testing. I wonder if there is a command sequence that I
> > could run to reproduce it?
> > Also, could you please send your config and qemu arguments.
> >
> Yes, here is the qemu config:
>
> qemu-system-x86_64
>         -machine accel=kvm
>         -machine pc-i440fx-2.6,accel=kvm,usb=off,vmport=off,dump-guest-core=off,nvdimm
>         -cpu Haswell-noTSX
>         -m 12G,slots=3,maxmem=44G
>         -realtime mlock=off
>         -smp 8,sockets=2,cores=4,threads=1
>         -numa node,nodeid=0,cpus=0-3,mem=6G
>         -numa node,nodeid=1,cpus=4-7,mem=6G
>         -numa node,nodeid=2
>         -numa node,nodeid=3
>         -drive file=/virt/fedora-test.qcow2,format=qcow2,if=none,id=drive-virtio-disk1
>         -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x9,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
>         -object memory-backend-file,id=mem1,share,mem-path=/virt/nvdimm1,size=16G,align=128M
>         -device nvdimm,memdev=mem1,id=nv1,label-size=2M,node=2
>         -object memory-backend-file,id=mem2,share,mem-path=/virt/nvdimm2,size=16G,align=128M
>         -device nvdimm,memdev=mem2,id=nv2,label-size=2M,node=3
>         -serial stdio
>         -display none
>
> For the command list - I'm using WIP patches to ndctl/daxctl to add the
> command I mentioned earlier. Using this command, I can reproduce the
> lockdep issue. I thought I should be able to reproduce the issue by
> onlining/offlining through sysfs directly too - something like:
>
>    node="$(cat /sys/bus/dax/devices/dax0.0/target_node)"
>    for mem in /sys/devices/system/node/node"$node"/memory*; do
>      echo "offline" > $mem/state
>    done
>
> But with that I can't reproduce the problem.
>
> I'll try to dig a bit deeper into what might be happening, the daxctl
> modifications simply amount to doing the same thing as above in C, so
> I'm not immediately sure what might be happening.
>
> If you're interested, I can post the ndctl patches - maybe as an RFC -
> to test with.

I could apply the patches and test with them. Also, could you please
send your kernel config.

Thank you,
Pasha

>
> Thanks,
> -Vishal
>
>
>
