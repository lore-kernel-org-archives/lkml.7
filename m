Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B51C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B94A2176F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Wf+YoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfDPXyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:54:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43638 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDPXyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:54:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so18523400oig.10;
        Tue, 16 Apr 2019 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPj4if145pByVuOcp7YZnDQ7+4SxDIxbN0q18+PcTr4=;
        b=K4Wf+YoTVIclcx5b09XBVfqMBw8FJB+a0p4R6M3SDQQkSOsQyxQm6mJGQcF2QV1cnl
         uZi50u9eCowJyMUWlUuwdtI7xdRB2W/x4ikIBt18igFjZe/uJaE1AIESM3Ii3tVs6uh3
         uLLGlgkYEpbc5oxLtM1XmeCVjHON7pqW4nep7tzsj0zrrk3JY5QCm7G1mhFWarKmaJXD
         bBUQt3kW78ZAsksCbnv4JVxdacJsOnn0jZ4g9Na8VRGCrZ7R9IxqTVmR6pKIOLNmo0/I
         Sjvo7VImy38aKYbiS3noLk6dPgco9vEbBUwZKRrz6b+WA24LW45AboE9oqTeFupHuqMQ
         omhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPj4if145pByVuOcp7YZnDQ7+4SxDIxbN0q18+PcTr4=;
        b=pScUUMoNsNcQgOWr6Io1DOp6y9boiPVXdeQHM6mFqineSDOPeaBHdxRi9Phw0yepKg
         heElWnn8yOZPA8WaHtCHCAe+ib8TpupYOrPpglsWx8POGh9lQT5d4BydUDG9rT4LlLYv
         TzUulMq8FLxRNW7PgI06wbxSBw+GV622ttFhtBbxbYr2MlIF3Q92MGIxSkM0qTgPdfuH
         B470zZBPpONLYGCWOA/W44wlxi9WZkIz7gC/SQ+FiiRBBSjsprKPFh3MycR+wU0pevkp
         ex6vJs3RLFYHSAEpHbS2ep6MTGT39cBv2+k3kfFVlB4JITcdiHaZ5HtkMWfOkE1iv1GI
         OuDA==
X-Gm-Message-State: APjAAAVWvrziJm4GhtJUXYqBHqelCUbwVzDXu84eLKxUy4+Xf7MmOLqi
        /WJ+Cdx9hNqGXF0d4qXtpXM=
X-Google-Smtp-Source: APXvYqy0SaoYQCg3yXmwy1BLzTCgDwQTo/+KCQU5nS1frlK2PfNPpKGPEHKnALfkAwybz6MRj3pBfw==
X-Received: by 2002:aca:abce:: with SMTP id u197mr25033162oie.67.1555458843074;
        Tue, 16 Apr 2019 16:54:03 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id x89sm25670727ota.30.2019.04.16.16.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:54:02 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 08/24] net: dsa: Be aware of switches where
 VLAN filtering is a global setting
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-9-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <af1ae138-933f-86f4-2ce3-0eb8be33f66a@gmail.com>
Date:   Tue, 16 Apr 2019 16:54:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190413012822.30931-9-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2019 18:28, Vladimir Oltean wrote:
> On some switches, the action of whether to parse VLAN frame headers and use
> that information for ingress admission is configurable, but not per
> port. Such is the case for the Broadcom BCM53xx and the NXP SJA1105
> families, for example. In that case, DSA can prevent the bridge core
> from trying to apply different VLAN filtering settings on net devices
> that belong to the same switch.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
