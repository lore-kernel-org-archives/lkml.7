Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3995CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F262520882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwwJaiVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfCaRQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:16:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfCaRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:16:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so8836406wrn.6;
        Sun, 31 Mar 2019 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2UMBM2cl3aL2/0tcntzJoQrX4s/pKpcX133TQvpp/hI=;
        b=UwwJaiVwcwXsevwpQMnBmx4uhha1L5BWG96xilbiUpD2h+KecFFXO/p/rDn2zKtzvB
         CIwaD+0DY7yprN+GgnsECqFluSVXxo+/M6P152ZTyyBXRPxFuhYxZv2XHerW0Anb5Z/c
         pU3/otKP8BXTgQSHtb1KK8lNWX/U4WZt0CorQKvNSHcPCIgnmhhkTJqhSYZ5BR4JbQ1T
         Gp7bKzVlyAOSAIwH+d/GRccc9VXDLTLQeOO8waPWVdll18ekop9bdvzmlaxH69962l2p
         a0mMFp4MWYgPw0VJbkfIfDCtZr6dCmDqVI1VTYVQsXd80NH9ZtZuT5Xi938lV7AvnMXH
         tQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UMBM2cl3aL2/0tcntzJoQrX4s/pKpcX133TQvpp/hI=;
        b=tO9LQtfyJ2nGCV9atl7U51prhPyXIJLVeA/ccwi6dhWCnQyl47HNEgjB4vhnhXpHY8
         Q2zMFb86uZH4kqDAREqzxDQny8Xip7QRyxpf++qJb+8PYM1da4J1Aj5n18fg06g/iJ4l
         AvNt5tCpWVgXDTIezbzVa5A67LXU9HLFPxx84Re1nI1gia0xHllkkp4l624Wrn1NCpRL
         Gni5m63jjoD9dGjraSBYKFjqI5YHT6EFa/53h3yY3FrNrpRGTwV0Zz60qPji5fHAHDeU
         wpErZ+AzQ9GerWxvX4DlETK2KNWUvNiP9FxRCsor+okd2FMI5HYs7OAzxgi+mjzT7PRM
         Wq0g==
X-Gm-Message-State: APjAAAWW16jGKIIqnLv8wfDcfkAajtcJsbKg34JRR6omSbD+Ov/f2HG9
        2v9iJr9GcjHNE4VEG5t3qh0=
X-Google-Smtp-Source: APXvYqxsz+MfYPkfMf4a+GFiLqQMtZu3UvDwWhKcs3ebK9FuYavFjBr5BIIJStMf+oaEzGeWiMKfhw==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr21620754wro.81.1554052580621;
        Sun, 31 Mar 2019 10:16:20 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id g84sm10547804wmf.25.2019.03.31.10.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 10:16:19 -0700 (PDT)
Date:   Sun, 31 Mar 2019 18:16:17 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/7] fbdev: sm712fb: use type "u8" for 8-bit I/O.
Message-ID: <20190331171617.ebh7aozv3eleyqzb@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-2-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-2-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:53PM +0800, Yifeng Li wrote:
> This commit converts "unsigned int" and "int" in I/O wrappers
> to "u8". It improves readability since it's consistent with
> the prototypes of readb() and writeb(). More importantly, it
> reduces readers' confusion, since the upcoming 2D acceleration
> code will use a different wordsize.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
