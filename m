Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A51C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254C321721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="bQ8Ccg7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfGBMDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:03:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38452 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfGBMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:03:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so710872wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gm6GhJ7gb2LUevWRbLpcuyKEIGbt2fZGuGZRBRjtrqo=;
        b=bQ8Ccg7NMvFz5SZ6bdMtcHci+tw+AVpOAcAvig717mhKAU267n1pDLGerYlOyaF/l/
         GlxVJVT+q9H9/5/2WnKqW2xmPMzmC68pRIhvKQ/EuvGokbZ/6C065TC3eQxl65Eo433N
         ESC/7CWXCxK7A/UwMJJACnJ+qqKjOQEBvzcOKti2c5cm69YOZFf+QOhcXTi42Rk3nyTP
         vb5ZjqySvu9iQcU5U8uCRP6n7OuTXCsLy1UbM04HCVP5W3D+ornDtdGemnIcjNtwxff/
         +FJkcvuItvzJTuKIEAnnDGKT+bHuHgnAmKMSEB8mrfm9fgG5cnpON3IPIWj/PjCjsrvN
         ZbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gm6GhJ7gb2LUevWRbLpcuyKEIGbt2fZGuGZRBRjtrqo=;
        b=CAf9vipv+KgM/+a7UdbdXB9UXTCeF7xXxEdVjeuXGB5thFi8jTWPEOLHyhuQVWQV7/
         EqKN0+sTRKwsi9VUXZofZ61SI4XggN1FUE0Q+WQO6tPFmzpflQjvE9wJF8SN1NxGJYt7
         bOT89uk8b3I1q6wTbKOmpUresLtVpbvn6l7z/5HkUWk7mlRQy4RQyZzg+cq9OxoRutGV
         7TdRTP9Rs1cTrBiIvqBc5GkCGCtzE1yylLZ53m+PbfUnedH+PSEw7XMBhXXu/iAjTtZU
         Rt+An+VaLiGGq8dYwJX8z+mZcn62u7vevkvCc1IhnUYhUTTjqN5y69bxAyHDxw+MaQrb
         xpkA==
X-Gm-Message-State: APjAAAV1u3+RUwL4XKMA2XTMu0E8S3dcJl5ipExNVDQd6JEI0gEb9X8Y
        oi9hqWqWBl6Nn8MSpvyniAQ=
X-Google-Smtp-Source: APXvYqzY1WIZXqGwqXvHrmdMUEorT4psdCq6z0c+xvUPrw4/kcZzicISqdSJdPPkYLHuIAf54uR9IQ==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3351914wmg.7.1562069016717;
        Tue, 02 Jul 2019 05:03:36 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id y16sm10463591wru.28.2019.07.02.05.03.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 05:03:36 -0700 (PDT)
Date:   Tue, 2 Jul 2019 14:03:35 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 02/15] netlink: rename
 nl80211_validate_nested() to nla_validate_nested()
Message-ID: <20190702120335.GM2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <d0c23ac629c4a0343acc9f09484e078962c55402.1562067622.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c23ac629c4a0343acc9f09484e078962c55402.1562067622.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jul 02, 2019 at 01:49:49PM CEST, mkubecek@suse.cz wrote:
>Function nl80211_validate_nested() is not specific to nl80211, it's
>a counterpart to nla_validate_nested_deprecated() with strict validation.
>For consistency with other validation and parse functions, rename it to
>nla_validate_nested().
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Acked-by: Jiri Pirko <jiri@mellanox.com>
