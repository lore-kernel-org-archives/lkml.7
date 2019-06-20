Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A391C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB0F2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="NKyS9gvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfFTHUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:20:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37228 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTHUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:20:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so1844995wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+cZZQUiAbSFZ5vyqDnl6i0sE8+BN4xzCapTjFH6GZ0=;
        b=NKyS9gvG9OoNVIU+wvtPkKl9LryqEO3a6YKp09Ltgm2Fy2zXIaW8+E4EQ12u7PS2e5
         8SdpcYMCN6RM9rvJzkG08F/aN5s6RwMWqJBrW6VgRebiPjO4Cn/K87QL7bLl9IHdCIhn
         UPNizEIG4VXvN0Hn+imu5VErvswc4D7xZte6EuJyp/h0q/Y3YHkIMjmrCjEZiUbUvF6Y
         ruTi9vRSxs7IkMW0vU9Tagcc4F4LV1PGouu5bl7W1pU+LpTWskTQrVAI99PkoEWuJX7/
         hIINIgntTJZjYDmA3oVCKI8raOCSyNQSnoDdAO+rvA/gM70m8rf5V/g14DMv3MTB7YGY
         0SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+cZZQUiAbSFZ5vyqDnl6i0sE8+BN4xzCapTjFH6GZ0=;
        b=O85wt7o24eXbTtbnApCP2JBvYKA3awz5HaIjUNn7dqp+PkIH0PyKCHwvJU6+2UuWc+
         yIeikTQER7XGn/RxCZYP+gavhOAsSX6E+1KsToCPPsSL4T/l7NRzUdva72DzkgpLIFlM
         qF/B87mlitcFTwQgMv7mHjG9sYK1XRWO9BRRrp5E2SGk5Vha2G3ysmbrKuyDvZnngowS
         q5hzJR6deOf8Oe3b1WN3thH+DSIsrJOGYhltCVyMrWCH/B+qcybTvugu3OadS2LaVoST
         h/5FB559dCKv6/zyof8jd0ttjIn4O7M1EvVqQ9v5loL22S6x4tguB3MfqGl8i3vJ6Exy
         OQ9w==
X-Gm-Message-State: APjAAAUfXQsVOOjmD28A3yr1iVevkrL7MLeA0HIHAO7U/rzM1afCpB/f
        3g/4ABNvbVvwf8jHymMJPFxqGQ==
X-Google-Smtp-Source: APXvYqzCBzd8J2M9XQvdsbL6G2OSFawF+v3rk18ZoTrCxdyxSjJU1aALri4iTJCgU4AEHIzAuQvoZw==
X-Received: by 2002:a05:6000:100a:: with SMTP id a10mr20639918wrx.154.1561015210289;
        Thu, 20 Jun 2019 00:20:10 -0700 (PDT)
Received: from localhost (ip-78-45-163-56.net.upcbroadband.cz. [78.45.163.56])
        by smtp.gmail.com with ESMTPSA id f204sm5291869wme.18.2019.06.20.00.20.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 00:20:09 -0700 (PDT)
Date:   Thu, 20 Jun 2019 09:20:09 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        sdf@google.com, jianbol@mellanox.com, jiri@mellanox.com,
        mirq-linux@rere.qmqm.pl, willemb@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] flow_dissector: Fix vlan header offset in
 __skb_flow_dissect
Message-ID: <20190620072009.GA2504@nanopsycho>
References: <20190619160132.38416-1-yuehaibing@huawei.com>
 <20190619183938.GA19111@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619183938.GA19111@mini-arch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jun 19, 2019 at 08:39:38PM CEST, sdf@fomichev.me wrote:
>On 06/20, YueHaibing wrote:
>> We build vlan on top of bonding interface, which vlan offload
>> is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
>> BOND_XMIT_POLICY_ENCAP34.
>> 
>> __skb_flow_dissect() fails to get information from protocol headers
>> encapsulated within vlan, because 'nhoff' is points to IP header,
>> so bond hashing is based on layer 2 info, which fails to distribute
>> packets across slaves.
>> 
>> Fixes: d5709f7ab776 ("flow_dissector: For stripped vlan, get vlan info from skb->vlan_tci")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  net/core/flow_dissector.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> index 415b95f..2a52abb 100644
>> --- a/net/core/flow_dissector.c
>> +++ b/net/core/flow_dissector.c
>> @@ -785,6 +785,9 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>>  		    skb && skb_vlan_tag_present(skb)) {
>>  			proto = skb->protocol;
>>  		} else {
>> +			if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX)
>> +				nhoff -=  sizeof(*vlan);
>> +
>Should we instead fix the place where the skb is allocated to properly
>pull vlan (skb_vlan_untag)? I'm not sure this particular place is

Yes.

>supposed to work with an skb. Having an skb with nhoff pointing to
>IP header but missing skb_vlan_tag_present() when with
>proto==ETH_P_8021xx seems weird.
>
>>  			vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
>>  						    data, hlen, &_vlan);
>>  			if (!vlan) {
>> -- 
>> 2.7.0
>> 
>> 
