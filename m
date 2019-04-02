Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9396520830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RpSvIgOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfDBPQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:16:52 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47749 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbfDBPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:16:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190402151650euoutp02120772e567fb937887c8ab940549bb96~RsTo8vTBx3119031190euoutp02s
        for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2019 15:16:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190402151650euoutp02120772e567fb937887c8ab940549bb96~RsTo8vTBx3119031190euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554218210;
        bh=g3bwEYXaj5anhxs7Shn/S69wYgDbFYDktOsp1C3zuTU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RpSvIgOcCCTFrox6oBNZMbfD6PaVu82aKuMXR9gWcw8RAZ9oU0y/8OCFqtQC/CDs0
         NNLr9JopVZ8iatcqeip/ALx+YHKlZItrXFntqT1ayJMry8Z98VIch1G5WMYSz7cL+k
         pmZuj1TneC09037yxrD0+Bqx4k4buUKL8UvgqO4w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190402151649eucas1p24051a6a7acc33ae4556ab32459e3910d~RsToRKJtH0690006900eucas1p2S;
        Tue,  2 Apr 2019 15:16:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 88.0A.04325.1EC73AC5; Tue,  2
        Apr 2019 16:16:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190402151648eucas1p2ec6ab2ac2f74b6644ed750f3c4e1f9ba~RsTnpgtmd0691506915eucas1p2b;
        Tue,  2 Apr 2019 15:16:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190402151648eusmtrp17132df8226db4bd7095899c0eb851d55~RsTnbhACf2099120991eusmtrp1s;
        Tue,  2 Apr 2019 15:16:48 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-1e-5ca37ce19489
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.49.04146.0EC73AC5; Tue,  2
        Apr 2019 16:16:48 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190402151648eusmtip12536b12871d332bd1bed91740d94d132~RsTnGCtN41665916659eusmtip1U;
        Tue,  2 Apr 2019 15:16:48 +0000 (GMT)
Subject: Re: linux-next: build warning after merge of the fbdev tree
To:     Tom Li <tomli@tomli.me>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <14da80ce-4a9e-3571-2aca-98c90634ee29@samsung.com>
Date:   Tue, 2 Apr 2019 17:16:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190402123849.GA4562@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87oPaxbHGFz+wWaxdY+qxZnuXIsT
        fR9YLS7vmsNmcXBhG6PFgdNTmC2mzcxxYPeY3XCRxWPdQVWPnbPuAnm7e1k9Pm+SC2CN4rJJ
        Sc3JLEst0rdL4Mo4+m4Pe0GrdMWTtpVsDYz9Yl2MnBwSAiYSvzs2MncxcnEICaxglLhw6zIr
        hPOFUeLF48nsIFVCAp8ZJRrPOMN0bDp1C6poOaPE0Xs7GSGct4wSex6+YgapEhZwkei70w1m
        iwhIS9x/9xZsB7PADCaJ/acOsIAk2ASsJCa2r2IEsXkF7CSOrv7FBmKzCKhInD77E2gFB4eo
        QIRE/xl1iBJBiZMzn4C1cgK1Ni48xwpiMwsYSBxZNAfKlpfY/nYO2C4JgXnsErfb1zNBnO0i
        selKC5QtLPHq+BZ2CFtG4vTkHhaIhnWMEn87XkB1b2eUWD75HxtElbXE4eMXWSFsR4lndzrA
        rpMQ4JO48VYQYjOfxKRt05khwrwSHW1CENVqEhuWbWCD2dW1cyUzhO0h0bftF9MERsVZSH6b
        heSfWUj+WcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw0Zz+d/zrDsZ9f5IOMQpw
        MCrx8FZELY4RYk0sK67MPcQowcGsJMJ7pn9BjBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeaoYH
        0UIC6YklqdmpqQWpRTBZJg5OqQbGI+2zdkp8MKzuZ5mRZnYuXJ1ZMVj/ycM/H/Y8E9167cza
        uxNmlP2YJ6B77htnpFSudc+kVXvj+B0Lzk5aFa/osvBDs+bG6KbIew1iFZGLLMLrNC0fOcT2
        1W7Xkjlhevbn5tv5DxgW9gYWXny+pmoRl83k0y7Z6+c+nnFjz9PaVS2+m+TvbnnPq8RSnJFo
        qMVcVJwIAOdA4K0wAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7oPahbHGJxZI2WxdY+qxZnuXIsT
        fR9YLS7vmsNmcXBhG6PFgdNTmC2mzcxxYPeY3XCRxWPdQVWPnbPuAnm7e1k9Pm+SC2CN0rMp
        yi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4+m4Pe0Gr
        dMWTtpVsDYz9Yl2MnBwSAiYSm07dYu1i5OIQEljKKHHo5T+mLkYOoISMxPH1ZRA1whJ/rnWx
        QdS8ZpR43X6dHSQhLOAi0XenmxnEFhGQlrj/7i0zRNEuRok/y56wgCSYBWYwSTw/7ApiswlY
        SUxsX8UIYvMK2EkcXf2LDcRmEVCROH32JyuILSoQIXHrYQcLRI2gxMmZEHM4gXobF55jhZip
        J7Hj+i8oW15i+9s5zBMYBWchaZmFpGwWkrIFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcx
        AqNn27Gfm3cwXtoYfIhRgINRiYf3QsziGCHWxLLiytxDjBIczEoivGf6F8QI8aYkVlalFuXH
        F5XmpBYfYjQFemIis5Rocj4wsvNK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQW
        wfQxcXBKNTDWFQjvfO85MX3OnbURTKnZnqv2Br+Z/+LAgqXaPMfuVj7/cGvJhi0ej7dXZ/kf
        tDa9rLf/w9y+lKYMze2eatd+hGQn3Tq+4e1vl0mF1vdeah6qFFqwa9/7oBvGkv6fHUq4zWf7
        8n36xZyy7HhPh7bsozPzbuRFsBae3cm345/1nXWnvs+sO/HSTYmlOCPRUIu5qDgRANCH3da0
        AgAA
X-CMS-MailID: 20190402151648eucas1p2ec6ab2ac2f74b6644ed750f3c4e1f9ba
X-Msg-Generator: CA
X-RootMTR: 20190402123908epcas3p4c3c3d6f66320a3d3ef1a47f700925cf1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190402123908epcas3p4c3c3d6f66320a3d3ef1a47f700925cf1
References: <20190402093007.0b03b02e@canb.auug.org.au>
        <CGME20190402123908epcas3p4c3c3d6f66320a3d3ef1a47f700925cf1@epcas3p4.samsung.com>
        <20190402123849.GA4562@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/2019 02:38 PM, Tom Li wrote:
> On Tue, Apr 02, 2019 at 09:30:07AM +1100, Stephen Rothwell wrote:
>> Hi Bartlomiej,
>>
>> After merging the fbdev tree, today's linux-next build (x86_64
>> allmodconfig) produced this warning:
>>
>> drivers/video/fbdev/sm712fb.c: In function 'smtc_blank':
>> drivers/video/fbdev/sm712fb.c:900:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     smtc_seqw(0x6b, 0x02);
>>     ^~~~~~~~~~~~~~~~~~~~~
>> drivers/video/fbdev/sm712fb.c:901:3: note: here
>>    case 0x720:
>>    ^~~~
>>
>> Introduced by commit
>>
>>   f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting")
>>
> 
> Nice catch! Thanks!
> 
> This bug was introduced by me while attempting to fix another issue, a result of
> my copy-paste error. Since it only reprograms the clock to a different frequency,
> it's only a benign issue without visible side-effect, so it also evaded Sudip
> Mukherjee's code review and regression tests.
> 
> But what's I'm more concerned here is the failure of scripts/checkpatch.pl. I
> thought ./checkpatch.pl should have caught it, but for some reasons it cannot
> detect this one.
> 
> $ ./scripts/checkpatch.pl 0001-fbdev-sm712fb-fix-crashes-and-garbled-display-during.patch
> total: 0 errors, 0 warnings, 105 lines checked
> 
> So I mistakenly assumed the patch doesn't have a problem... It seems checkpatch.pl
> cannot detect fallthroughs in nested switch/case statements? I'm not sure. Should I
> report it to the maintainers of checkpatch.pl?
> 
> Anyway, please apply the following patch ASAP.
> 
> Thanks,
> Tom Li
> 
>>From 040fa4e6cc8b338cd845c11fd3efd7394ca55108 Mon Sep 17 00:00:00 2001
> From: Yifeng Li <tomli@tomli.me>
> Date: Tue, 2 Apr 2019 20:25:20 +0800
> Subject: [PATCH] fbdev: sm712fb: fix memory frequency by avoiding a
>  switch/case fallthrough.
> 
> A fallthrough in switch/case was introduced in f627caf55b8e ("fbdev:
> sm712fb: fix crashes and garbled display during DPMS modesetting"),
> due to my copy-paste error, which would cause the memory clock frequency
> for SM720 to be programmed to SM712.
> 
> Since it only reprograms the clock to a different frequency, it's only
> a benign issue without visible side-effect, so it also evaded Sudip
> Mukherjee's code review and regression tests. scripts/checkpatch.pl
> also failed to discover the issue, possibly due to nested switch
> statements.
> 
> This issue was found by Stephen Rothwell by building linux-next with
> -Wimplicit-fallthrough.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting")
> Signed-off-by: Yifeng Li <tomli@tomli.me>

Applied to fbdev-for-next, thanks!

> ---
>  drivers/video/fbdev/sm712fb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 1e2503b52c6f..f1dcc6766d1e 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -898,6 +898,7 @@ static int smtc_blank(int blank_mode, struct fb_info *info)
>  		case 0x712:
>  			smtc_seqw(0x6a, 0x16);
>  			smtc_seqw(0x6b, 0x02);
> +			break;
>  		case 0x720:
>  			smtc_seqw(0x6a, 0x0d);
>  			smtc_seqw(0x6b, 0x02);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
