Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06891C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtxGR+3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfCaMUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:20:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45588 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfCaMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:20:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so8229761wra.12;
        Sun, 31 Mar 2019 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ0am21wXsBjAY4fGCkqznyBgqEJNYiZWFMHqKdn47w=;
        b=KtxGR+3GtYFt++rnmR1tgSAMDxDWki7ETY7ymQTQ2mQPCgVg7CS0LRGjmku5JPk4+t
         BadDyU7Jgx0lWHBZsA+pZGfI2TaZuLcbHpcK+pj5qhOY2YOkMA3TzZ3yQvDaCXnBPsHU
         bxUihuNAPUDvPidjbJ1DdXvLzY4u/w5PDUllp0F/AVlpOR7tD+C3OweUIFPGbFStlWYr
         LI1GQGqsegqMLBV71OnxeAT2paTmx0WL9wF5NkfAep9qkQAmCmS+Yyf/ErQeX+KIkocf
         JvhYNvQefZk29Zs5NU46nrRLK3Sk1pWeZWq9DGkQXp3zvjVthPBSbiXgpPDHF4yNngqs
         Xzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ0am21wXsBjAY4fGCkqznyBgqEJNYiZWFMHqKdn47w=;
        b=UldLsSvaijS4HDZ56nmq2EuneBqbT/Om6BBKk8PvtDo2VIusqoJA5/YNT5PIH8b/fN
         i/xOxV6w0ISp2xWS6kPL9FKHBTQslBLXT3QnZg4+GeENLnC4EIuURvxzXBOMiEhFuT0X
         nNtY8esXqJqbj+GXgCgb9ZYeH4uvPbBVpYArn7B2zuHjdKstHSEQuKz0mkQSNQ2f+/ZN
         8R91TVgC+2BNWLBPQFWR+24cFq5gF5tczEbM+9nJGT4JvFddmZSE+E/RrT2lyJb2rx4H
         E3/4Zx/L9xcpgGm2JCdW+17yQzH+MmQGjxui3tlaDDi6FJyhNJUXtYc1CJGkdhPoGQHR
         ns7g==
X-Gm-Message-State: APjAAAWS/tZQqTIzqdjNE69iCES5fHlo6ty7wmBBZQyQZainqAPPIhvw
        qdYN8ANWIstzVyEJBCsxz+0=
X-Google-Smtp-Source: APXvYqzpVN2ckPIdITb8bzyr9EVDpS8v2J4m6oQ/23C6utO4hex2TyxmFFsxZEEP8Q5GCtUtvePizg==
X-Received: by 2002:adf:f451:: with SMTP id f17mr34831560wrp.272.1554034849311;
        Sun, 31 Mar 2019 05:20:49 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id n189sm10304218wmb.28.2019.03.31.05.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:20:48 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:20:46 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 7/8] fbdev: sm712fb: fix support for 1024x768-16 mode.
Message-ID: <20190331122046.dcdffbrifgphttpn@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-8-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-8-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:03AM +0800, Yifeng Li wrote:
> In order to support the 1024x600 panel on Yeeloong Loongson MIPS
> laptop, the original 1024x768-16 table was modified to 1024x600-16,
> without leaving the original. It causes problem on x86 laptop as
> the 1024x768-16 support was still claimed but not working.
> 
> Fix it by introducing the 1024x768-16 mode.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
