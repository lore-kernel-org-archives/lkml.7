Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5C720868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7K9VpyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfDPX7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:59:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39047 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:59:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id n187so18543274oih.6;
        Tue, 16 Apr 2019 16:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IlKMbwbSbQIv5IsvCg8TANjz96nTT9jT9js7ccxmDk8=;
        b=R7K9VpyA5CODFz04LdETRMHjK5NvxGWITW8y6262ugxcDdDOGdvp49Di94Wgem04Gm
         9kY8ySPjZUcUmUuBndGBg7HkT/hisBRj8K5qakrymxZkPTkCf9BTgbEea7nPiVYLJZNA
         3J/myviLXzwW8N1oNDiHU4a2aEl4Vcf0rSs12oV6CGGVFVnq4T5WFkUEcgkd6lmMNioM
         9VFhgqtqn+1Jy3AaU22N7BBaoPhdirCUYP+cHQX8LsDvop04UbrfTe5rZsW8a7pEedpl
         /DHg8aa9WyXZc1nRyTJ1BnOMz+GwEAh5nu/S6tAvE0ub92MM6BCbj7NVwGKBQkJNIyQq
         j98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IlKMbwbSbQIv5IsvCg8TANjz96nTT9jT9js7ccxmDk8=;
        b=Hx55r9FNBYOXzIB+UNIlWSQnxOuNy+sLsU+djybBfOhlp4mhsdtiDKDNhbOMUbeIAi
         ESTgfTZA7sbIlvsfahAYXKQOHt4jN7xwVqB9o3jgvE9Tqm+ChGrptpxUfL55tpsbKV9l
         beE7/D12HaUsvDKRQuuxO7TOulSbhqhwPNBjOC7m/8aD6e6Uvwycvh7dZUVuxuS9KYcw
         MnfWrYW11RsVIycIE7vYCltf4HxwVVeL8a8AVDdGyQ/VcXRaGd/K1kLj+AmglzSp8iUY
         6S/G62aXfXv1aU14zPlSqTtQR0tK5lb9+XUHuvKtAn5Iq5ANHrq29ikQPbstMkHIzudU
         SBhA==
X-Gm-Message-State: APjAAAVb2qvBmUCmTJIiDzXP49kGZtXY/NVKhwWebPAj7TbNLAUgmR8i
        GuUNf3M/9CGr2tMTiBK7tf4=
X-Google-Smtp-Source: APXvYqzU7fKNFUD3Xu8O0f4lszKt5aNOUIPPnJgdGN1EklmfFIeL9YhZjtI04nYYOv2P1kopLso68w==
X-Received: by 2002:aca:3405:: with SMTP id b5mr25799108oia.40.1555459154370;
        Tue, 16 Apr 2019 16:59:14 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id w131sm21489015oig.29.2019.04.16.16.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:59:13 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 10/24] net: dsa: Unset vlan_filtering when
 ports leave the bridge
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-11-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0e495944-0783-5bd4-0573-f6deb6f50b1b@gmail.com>
Date:   Tue, 16 Apr 2019 16:59:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190413012822.30931-11-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2019 18:28, Vladimir Oltean wrote:
> When ports are standalone (after they left the bridge), they should have
> no VLAN filtering semantics (they should pass all traffic to the CPU).

The reset of the commit message is fine but this particular sentence 
sort of conflicts with the fact that we set NETIF_F_VLAN_RX_CTAG after 
my recent changes in order to support standalone ports + bridge ports w/ 
VLAN filtering on. What this feature flag means is that ingress VLAN 
filtering is active/supported.

On that particular topic this also means that for things like tcpdump to 
keep working on standalone ports while we have bridged ports w/ VLAN 
filtering turned on, we might have to re-configure how the switch 
performs ingress VLAN filtering checking when we have a standalone port 
in promiscuous mode. On BCM53xx we can achieve that by having the CPU 
port be part of all VLANs (there is a shorthand register for that 
purpose) and doing ingress VID checking + copy violated frames to CPU 
port. Food for thought...

> Currently this is not true for switchdev drivers, because the bridge
> "forgets" to unset that.
> 
> Normally one would think that doing this at the bridge layer would be a
> better idea, i.e. call br_vlan_filter_toggle() from br_del_if(), similar
> to how nbp_vlan_init() is called from br_add_if().
> 
> However what complicates that approach, and makes this one preferable,
> is the fact that for the bridge core, vlan_filtering is a per-bridge
> setting, whereas for switchdev/DSA it is per-port. Also there are
> switches where the setting is per the entire device, and unsetting
> vlan_filtering one by one, for each leaving port, would not be possible
> from the bridge core without a certain level of awareness. So do this in
> DSA and let drivers be unaware of it.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
