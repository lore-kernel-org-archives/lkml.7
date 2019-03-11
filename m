Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F22C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292792075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="iaqgcbed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfCKK3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:29:15 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39264 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfCKK3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:29:14 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so2991249lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/iIbH8ygU+CPfdNbiqaQx0rc/64Julz8OAtkMlAvsac=;
        b=iaqgcbedCX9keCWsUCVOpIv3XE6W5qbMGdwe2NtumYrArmo4PrPqZRS8Ggv4ONtl0f
         HbdFEN9FyL237hOnGu8qbTJu2ZPwtUpJaTU09oYgkpcUi+9lfxFDI8sdbbP1Vf+YVy00
         02nZVahzLK5/wnQ5bG2m9SOBmYT81SGN+Ntnp4ToZ9wf7GqNakr8ujdT816odOVT7HZJ
         LlM4p6lEhkT2T8JkUEseA48XxjsdlPM9ZWOgsNCgcrfpXhTbNswIFqwrho+1zvwlQhHM
         f8BfVkZo/fkw7hU/5kgi+QI1k/UKE7ZuXg+4O1Om5e4n+oo2x8d4YLCfKNL9WecPXZgV
         PLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/iIbH8ygU+CPfdNbiqaQx0rc/64Julz8OAtkMlAvsac=;
        b=AgclDXpX93L2tHxveKjLwGno4Mp0bMVQclnJIw9pzWWIeXUs+56jGPgwipOZqdj5GV
         FTqi6+oSKjfi/f5iSyaRi4W9rHuzL2H0Z4HXq24STHip9n9/neXY3Y5JhwytM4NeJl4X
         ydEevWSbv26knnwjzSrjOwAy4IjkGwdstfxoou/FD+6u+6+6cokK9s4kSlEN8DSrmoUL
         zDo5bqTDf174puCXrOZD/dHlWX0ydCm8vCsTz9mobr9QG/3Zyaa4OQasB5xG5EyATMET
         Tq7vvhfjOduJVu5mrqxfTdYRNLTjsht+RZfSkLlcDAy+OlMrIWL6pUorD4sI+D6SiMjZ
         2ESA==
X-Gm-Message-State: APjAAAWkIokz81HJd28KQdSne/300+yqZTdwv+NdUbpeN67wimnwxEGn
        l2/Bw1yJqvU+XggLkQn1QSPAchA6YZ4=
X-Google-Smtp-Source: APXvYqxx/ZuQlNcNAts6twSmIJQ+WOpy9SY8Vpc7wKR9j2XjKLhA9bEJVSCdPOXF+cJW5E810PXIzA==
X-Received: by 2002:a19:4f44:: with SMTP id a4mr6922335lfk.72.1552300152058;
        Mon, 11 Mar 2019 03:29:12 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.180])
        by smtp.gmail.com with ESMTPSA id g16sm1045902lfb.56.2019.03.11.03.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 03:29:11 -0700 (PDT)
Subject: Re: [PATCH v2] net: renesas: fix a missing check of of_get_phy_mode
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190311074939.517-1-kjlu@umn.edu>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <20c5cfde-3c2d-43cb-efc4-be9782b7eb2e@cogentembedded.com>
Date:   Mon, 11 Mar 2019 13:29:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190311074939.517-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/11/2019 10:49 AM, Kangjie Lu wrote:

> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> returns NULL of it fails.

  Sorry, I overlooked this issue.

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Fixes: b356e978e92f ("sh_eth: add device tree support")
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>  drivers/net/ethernet/renesas/sh_eth.c | 2 ++
>  1 file changed, 2 insertions(+)

   Why are you not fixing ravb_main.c as well? Especially as you have "renesas:"
in your subject, not "sh_eth:"? :-/

[...]

MBR, Sergei
