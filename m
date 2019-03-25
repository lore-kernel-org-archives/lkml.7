Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC939C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F4A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="edUGzOpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfCYIyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:54:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfCYIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:54:22 -0400
Received: from [192.168.0.14] (pd95c0187.dip0.t-ipconnect.de [217.92.1.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E5231EC02D1;
        Mon, 25 Mar 2019 09:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553504061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z53EwizmjIyxN10SgYjxj3UycnodzftL3CAyddh94Xs=;
        b=edUGzOppLyx7tUFB94Vly2sQwm9VqtBIhYlkOP49RBq6xI8o56blNZ//T/TDKm0Wg6L7Gi
        pb8rwxi7g41CLCfq/uN2wBqO2NgH+XEAERA2Dpr0ivOGPmLXGK67T//PcbZGz7C/ObHnds
        OOy8a0bvScJZFHQ32kXGHGJqtxv71HE=
Date:   Mon, 25 Mar 2019 09:54:19 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp> <20190322152328.GD12472@zn.tnic> <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp> <20190325060128.GB9385@dhcp-128-65.nay.redhat.com> <20190325061929.GC9385@dhcp-128-65.nay.redhat.com> <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com> <20190325065921.GA11096@dhcp-128-65.nay.redhat.com> <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "bp@suse.de" <bp@suse.de>, "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 25, 2019 9:27:21 AM GMT+01:00, Junichi Nomura <j-nomura@ce=2Ejp=2E=
nec=2Ecom> wrote:
>On 3/25/19 3:59 PM, Dave Young wrote:
>> On 03/25/19 at 06:47am, Junichi Nomura wrote:
>>> On 3/25/19 3:19 PM, Dave Young wrote:
>>>> On 03/25/19 at 02:01pm, Dave Young wrote:
>>>> I think normally people do not see this bug, because kernel will
>set the
>>>> rsdp in boot_params->acpi_rsdp_addr=2E  Maybe you are testing with
>>>
>>> I think it's only done for file-based kexec interface=2E
>>=20
>> Saw Kairui's another reply, yes, kexec-tools need a patch to fill the
>> value as well then=2E
>>=20
>> I would vote for a repost of your old patch with some #ifdef
>
>Thanks for comments, Dave, Kairui and Baoquan=2E
>
>The problem for me is it's a regression in v5=2E1-rc1, that breaks
>existing setup=2E If early parsing of RSDP is required only for newly
>supported configuration, I'm fine such configuration requires
>new tools or new options=2E
>
>This is the 1st version plus #ifdef around the EFI code=2E

I'm going to repeat that again until you get it:

If the kexec kernel should continue to use efi_systab_init() then you
should make efi_get_rsdp_addr() exit early in the kexec-ed kernel=2E
--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
