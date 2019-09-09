Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D7C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9377220863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kU+pQQQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfIIPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:31:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfIIPbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:31:49 -0400
Received: from zn.tnic (p200300EC2F063A00610A87590F9D5C05.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3a00:610a:8759:f9d:5c05])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A4DE1EC0691;
        Mon,  9 Sep 2019 17:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568043104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ex7SfPjpPGrCEdpGE4bZ7WX94CX3cwfuYEx/SwwYycY=;
        b=kU+pQQQExRjbKXisXC64gqVB3LDU+uNq4O/QqPIADJbspOhwSUSCu/So98PUDjvCnHHfv2
        RzYSJzK+ffABXh+RHznFAp8aJAzgxGczKyW5NBygz8a9AG8ptuezLhBGcO2suVI2rREypj
        u86ykC3UarqEHMzJ/lPNN8U7ubxcLlg=
Date:   Mon, 9 Sep 2019 17:31:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Message-ID: <20190909153137.GA22225@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-9-Yazen.Ghannam@amd.com>
 <20190829092241.GB1312@zn.tnic>
 <SN6PR12MB26393DDA0F1818DCDD2D7953F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190906203519.GN19008@zn.tnic>
 <SN6PR12MB2639232DF612AD2B02CFAAA4F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639232DF612AD2B02CFAAA4F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:49:52PM +0000, Ghannam, Yazen wrote:
> All the fields are register values, and there are unique instances for
> each channel. They can potentially all be different.

Hmm, ok, that's 160 bytes more per node. And on !Rome it is wasted. Oh
well, let's remain conservative then and allocate it only where needed.

Btw, upon a second look, compute_num_umcs() can be made part of
get_hardware_info() instead of having this as a separate function which
gets called only once before probe_one_instance().

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
