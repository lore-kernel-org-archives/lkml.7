Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4C4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B658206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="u61jC3dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfLJSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:43:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51314 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfLJSnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:43:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so1126029wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/T5WjX6H/ErjoxiBfZBOaK9N8M3Emjx06kbzRJKScRU=;
        b=u61jC3dd5btuU1LTirGEHKGHO/sJAFpAvEbzr+r1IhSxUBB5d0YLbmzQBXxIGwpBqC
         dyShA8AuIfIsoS6Gt89TdqqcNVg4/oxz9xEbe43RzdYkG00ZvC74qekSPQ4p4RVpYWS0
         erL4Shrlk+eanoB++nsy6IlIDey4C0c5fJYz8A18wCVW3s4aZgx/X+UsPX+XKO1MLNU6
         5jWbrMHbQk61z+gM/h8jjPZ08CyI4F4iTrqWSz7cOkoagX2DbAFgXX6PXs7sJrQBTJ1h
         Fdv4BNBKcV42OHJJQe1DoQTwprZLJkMe9B2qIF5lFvN1pws65xCHBUq3ao8/2bwpghuw
         bXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/T5WjX6H/ErjoxiBfZBOaK9N8M3Emjx06kbzRJKScRU=;
        b=fmiv9rQ+tDPY0jpMQP897ZLBCjR6j/BZtmI0oK4pLge4el2bOQFQu7NyN4GllxcgOb
         DmVNLEhjY+lE2LSJZy4tTpWYO9bslSXn0js+Md/CGVQlSqG/dZ2aJhwYLDN67/63qYMS
         Nwd5kQYcczxrtc3Y6ls3cNOXsZSsRhvpB9NuL5FadqpO4Khci2JKHR9VOdCyvcExau+/
         svzNC2cjy8TopV+EL0j81fnjIIIYmcJWSTm0TDB+ipg9VsVlbSlfdruOADmxaL6zG3rL
         lukdE2oNg8Eza2TkaJtTmgdIelSzrrJsJJIkVwoE+TQ9n2IQPXkSOHnOcCAmcaWtYOwR
         l84g==
X-Gm-Message-State: APjAAAWUrUCTag5KDPlF3Ldv4u1LTUdye4NkOnB3T4QKaz9+8afPxnz6
        jMHrQvH/SaWanyiTiImnrl2JLw==
X-Google-Smtp-Source: APXvYqxvMexfjRMDF/ZdvhMlXOWa9ckksgWIQ7Dd4HvHvuiFS9+JslyuWH/yANwKzxTom9TBT9/iKw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr6749458wml.67.1576003424871;
        Tue, 10 Dec 2019 10:43:44 -0800 (PST)
Received: from localhost (ip-94-113-220-172.net.upcbroadband.cz. [94.113.220.172])
        by smtp.gmail.com with ESMTPSA id o4sm4121296wrx.25.2019.12.10.10.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:43:44 -0800 (PST)
Date:   Tue, 10 Dec 2019 19:43:43 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20191210184343.GB7075@nanopsycho>
References: <cover.1575982069.git.mkubecek@suse.cz>
 <7c28b1aa87436515de39e04206db36f6f374dc2f.1575982069.git.mkubecek@suse.cz>
 <20191210095105.1f0008f5@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210095105.1f0008f5@cakuba.netronome.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Dec 10, 2019 at 06:51:05PM CET, jakub.kicinski@netronome.com wrote:
>On Tue, 10 Dec 2019 14:07:53 +0100 (CET), Michal Kubecek wrote:
>> @@ -1822,6 +1826,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
>>  	[IFLA_PROP_LIST]	= { .type = NLA_NESTED },
>>  	[IFLA_ALT_IFNAME]	= { .type = NLA_STRING,
>>  				    .len = ALTIFNAMSIZ - 1 },
>> +	[IFLA_PERM_ADDRESS]	= { .type = NLA_REJECT },
>>  };
>>  
>>  static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
>
>Jiri, I just noticed ifla_policy didn't get strict_start_type set when
>ALT_IFNAME was added, should we add it in net? 🤔

Hmm, I guess that is a good idea.
