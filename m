Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5FDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211D72070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV21JUG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfFDUfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:35:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34823 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:35:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so5409353pgl.2;
        Tue, 04 Jun 2019 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6qj//DmBzKyv27IYTdT81caJN/gQm8wzDZgiyqoLawY=;
        b=PV21JUG8RHNG9Clu/w06cbzs3wu3YgWr9p3r0T1O2VLOalMuV4mDosdeSX456Pqrpu
         4offUi/3LaCpFWNyA3XIyIJUwlhF2iFWGajGi2DDF2vcYuAvS6yNVn89v/pT1Z91N27K
         QJBTDcTnm4OGyMCvZc6eMKwk77JyJrOlJ/zpZb8jbCnhQK6PrLKF1k0Tn5Hg5rS+GYed
         cmXVHJqwi9gAO8sA6ryXfhuByEkzRPfpg470Fq5UY34vnuGNdNhooXGEMaJ32jNOhVH/
         UYI8w/0KS9xXnWq+AVynpgHztIui+jOhLJ7ZFI1GDzwBjSMAVICcIUQnwpKeEdru2tTu
         GGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6qj//DmBzKyv27IYTdT81caJN/gQm8wzDZgiyqoLawY=;
        b=G0rF2yzSKO8hHxBVJSguJ3nSU/z0MVfiqrY/FU4F3bIU7TW6bTDt3urfPOs+2mcpNy
         60GyyZeAFs7FU+gm7mt1LB+2B0wjaIP7ao1IiJK66WZG6VXGHo+gmU7RQPr1bLKvnIlC
         eW9Mq5iL9ffi4tZPb4a/njHUNECEWye8iJB6BGse58mB9XlZ+EXAu5rtnNc4dTH2Tcil
         XfrX5HdkiaxXZXN1+kvAuexIlbVoVecjK8xTamCa0H5DjWzEmVanbA1+xIlYZadFNeBO
         YosTFMynZ9qUZRi0JyC2Meivuh7qUMSzbOi5/c15ODWjUsely3SBL7rej/rTaQdl45gq
         RJlQ==
X-Gm-Message-State: APjAAAWAeM2WP2ljD4sEj7xLJLOU/uVyxRte9F4WZUqB/MLNCYj/7qyu
        qPFYFUJZtrH2Oez08yYRAEFWQupc
X-Google-Smtp-Source: APXvYqzPOWQdw9Rl8dYdqs5anqLV7ETnzm8+dokWJ+A4+7JK2wd3Lab0O//a4F2NOBrvAK99AG64Bw==
X-Received: by 2002:a63:6e48:: with SMTP id j69mr611892pgc.34.1559680546107;
        Tue, 04 Jun 2019 13:35:46 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id 132sm6508789pfz.83.2019.06.04.13.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:35:45 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 08/17] net: dsa: sja1105: Move
 sja1105_is_link_local to include/linux
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net, richardcochran@gmail.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190604170756.14338-1-olteanv@gmail.com>
 <20190604170756.14338-9-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <5459cccd-d945-34a6-d20d-2e0487bb524a@gmail.com>
Date:   Tue, 4 Jun 2019 13:35:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604170756.14338-9-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/2019 10:07 AM, Vladimir Oltean wrote:
> This function will be reused from the .port_rxtstamp callback to see if
> the received SKB can be timestamped by the switch.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
