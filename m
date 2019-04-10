Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336C4C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59302133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R51B2yKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDJCBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:01:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35483 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfDJCBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:01:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so375704plp.2;
        Tue, 09 Apr 2019 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cC06TFG6bUI/16V2fT5D5OWzacR5TW4B1dpDIaW88yc=;
        b=R51B2yKmlBNhxJrzKPxrdE+pscvZ3CVNfJhhe+Rs3HIEF0tf2rfTYxyGXIfGub+QZv
         U1vZ7PjdPtmDLApRLJeh6aALwrqvWPe5sYk7kbz4Bh9Y5Hh4hV5VIZDSsPFGuNRazsAo
         nJZpX756ye1IL81r72Ji3sYBAa9wcE9DrzVr5wxsycvSo+aiZU87zA8aNQJXklznLPvo
         rcXMNaxE65Gbmrn11BGNb2e8wc6UKIe5YHZuEsRXwFEGNQrNiiF41JGXDQOCwj5qSY/5
         vB6d6NL7Pr32tbqy3UeX+69TXps4/POdwc/hV1qRM2FZ7mA21DnwZmL5wJnD2skLFPsM
         Q9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cC06TFG6bUI/16V2fT5D5OWzacR5TW4B1dpDIaW88yc=;
        b=lsua/+OAXYWl9mVcI02N91Lgok+aKmtLXBOOZG2DR9YFL/31hDBj0RWehoDf+jmwaD
         DnKBocjUizEK0aWjxv33hP88HndJ9Pynj5fkuAaNE3hrqrNFXW4UDG3LzT5rnWyPDkDZ
         XZEjtr5IbRsOphdicJboERUPT5uyt7cC5tJk60VrfinmffmVvFi0UB3bkP6qlGGziMGV
         54yMY4mPmUZWEEiz6nN8ShwVdwAIu1yNkiaZSYx8PI3cms6AUUw4h4VtKTDXYLseeD5b
         54S+drq6ZUB3LW+CQHQf5CLgSsWwAhS8C71V7Lx4NYx8KDzEqoO16+q9xiLLPDixct4i
         sxIw==
X-Gm-Message-State: APjAAAXiTkMYu3QaUd+q23v0dx4vtlTj1+P2JYePUrJJlaIiXz1lcBZ2
        ZySfRhdrmzvZo4g9m4gqwXw=
X-Google-Smtp-Source: APXvYqx2BmtgVrtR0TviUcNP2kszX6fsRbpfyLjkE+J+0I6d16sR7IZ9xheekyUKC0Bi+176a11g1A==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr41281857plv.113.1554861713643;
        Tue, 09 Apr 2019 19:01:53 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id m23sm51470081pfa.117.2019.04.09.19.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:01:52 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 05/22] net: dsa: Add more convenient functions
 for installing port VLANs
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-6-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d9f4ec44-7cc6-0ffe-9d02-eb1b1b818340@gmail.com>
Date:   Tue, 9 Apr 2019 19:01:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-6-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> This hides the need to perform a two-phase transaction and construct a
> switchdev_obj_port_vlan struct.
> 
> Call graph (including a function that will be introduced in a follow-up
> patch) looks like this now (same for the *_vlan_del function):
> 
> dsa_slave_vlan_rx_add_vid   dsa_port_setup_8021q_tagging
>             |                        |
>             |                        |
>             |          +-------------+
>             |          |
>             v          v
>            dsa_port_vid_add      dsa_slave_port_obj_add
>                   |                         |
>                   +-------+         +-------+
>                           |         |
>                           v         v
>                        dsa_port_vlan_add
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> ---
> Changes in v2:
> Renamed __dsa_port_vlan_add to dsa_port_vid_add and not to
> dsa_port_vlan_add_trans, as suggested, because the corresponding _del function
> does not have a transactional phase and the naming is more uniform this way.

Thanks the name does look a lot better now.

[snip]

> +int dsa_port_vid_del(struct dsa_port *dp, u16 vid)
> +{
> +	struct switchdev_obj_port_vlan vlan = {
> +		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
> +		.vid_begin = vid,
> +		.vid_end = vid,
> +	};

Any reasons why this function does not take a flags argument? Also, did
you intend to migrate dsa_slave_vlan_rx_kill_vid() to use this helper
for deleting a VLAN ID?
-- 
Florian
