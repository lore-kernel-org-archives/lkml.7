Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF87C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0920449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qMcVltDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfDSSe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36384 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbfDSSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:34:02 -0400
Received: from zn.tnic (p200300EC2F112E006C6C37C052F44BC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:6c6c:37c0:52f4:4bc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9FCE1EC04B9;
        Fri, 19 Apr 2019 13:28:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555673287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kt13yk+NKdfiWFO/sWb2l+mHuf8xiV4zJjS1XefOfVQ=;
        b=qMcVltDQi/FSqb+ryguk7TJsERARDdIDFiulUbh6pQb32vuPqpRuugzkLI6GyM0NE5UtQu
        SeeeTVQrXuGmXK2F1cIYWfLe6JtmVvnMlDxaezolqXujDh+orvkqzbbrY90H7Ak2gupCsG
        7JkwyGXS5+Q55lTqU2D1i1AD27c7CRA=
Date:   Fri, 19 Apr 2019 13:28:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419112801.GB10324@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419105014.GE11060@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 06:50:14PM +0800, Baoquan He wrote:
> Talked with Kairui privately just now. Seems Junichi's patch need add
> this systab mapping. Since the systab region is not mapped on some
> machines. Those machine don't have this issue because they got systab
> region luckily coverred by 1 GB page mapping in 1st kernel before
> kexec jumping.

You don't have to repeat all I that - I know what the problem is. Read
what I said again: it is too late for 5.1 to do any involved surgery.

> > 2. Then, the fact whether the kernel has been kexec'ed and which
> > addresses it should use early, should all be passed through boot_params
> > which is either setup by kexec(1) or by the first kernel itself, in the
> > kexec_file_load() case.
> 
> Seems no better way to check if it's kexec-ed kernel, except of the
> setup data checking of kexec-ed kernel.

Why does that "seem" so?

Read again what I said: "should all be passed through boot_params".
Which means, boot_params should be extended with a field of a flag to
say: "this is a kexec'ed kernel".

If it "seems" then it should be made to not "seem" but to work properly.

> Yeah, adding the systab mapping looks good. Kairui put it in
> decompressing stage just because he wants to cover the case in which the
> old kernel kexec jumping to 2nd kernel. Now it seems not very
> reasonable, we also have the new kernel kexec jumping to old 2nd kernel.

I don't think we can guarantee kexec between old<->new kernel to always
work. Otherwise, we can forget all development and improvements of new
kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
