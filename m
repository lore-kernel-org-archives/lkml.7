Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB864C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C94D2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="gytG0shM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfC1Rf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:35:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40301 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfC1Rf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:35:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so5080937wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z09ZmA/sYL1YnhVcIfoH0keMS/jvuxeTvyDtkBdPX4E=;
        b=gytG0shMKCwSSRLZ+jDVFXHHiwyviH3RcJRbaTVNM74777GpBFUjNqK2oqZPtaAqaq
         11tvDuF8UsAwiUIFIh8ppSSGxphCDELnEJAs3SF1Sa3YMgbJerTFdAsdkHE+u/6TtB71
         Uy8+3h+9+4GFvqakIiBH4zZcLI5UKg9gJdbQ4LQyhQe0NJevyFyh/NoD4GL8uFeX/dxu
         h96fzk+Sd+fPbTdaUfmaw0xBg8Bcku5MLJUrH5eThPNvBN22hePV4MMAx5y1ybqT5VpW
         wOTR68Qp8eJRSpFAqKsuFIp36FCp4HliJwxnQL6t7IkKdaYX9Eyw6gfk6Z9/yXfgYnha
         cknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z09ZmA/sYL1YnhVcIfoH0keMS/jvuxeTvyDtkBdPX4E=;
        b=HJUMucr/xb2g8+xUvOwe4UxI3y8WcKnh0zYKqWOd7Jv+oTB2Xyr4/1lMzD1rU0nKLh
         1y7GCDvXCWNrpzoiH6BAJVB5zKRLa5oMLb5gUwH8n5BOEFK43wRuBsal3pI6ErODHRUJ
         SKU+R9k9glN28CpOtAGLDaHl+v3/HDuxX//o9uI+9rnkOe95dxZ5Usjz4lt4JjFRZ2AW
         0XcRCjAvpIPuCJd+ipDITkPqrOsnnQ6ftQdO39qpgmmTEk3mjBHrpi3XtSV36d6MHTrd
         Aj6+W/7zqS2hNWJnfF85WFjZQqHovQ9K8hR027eTa6cHvj78ndtD3kPsXhKT+yEwolVv
         s56w==
X-Gm-Message-State: APjAAAVE6VaUTsioFQNTviKC3oyfXaEg3IlT08QL+2ARyOpfZL6UmQMD
        0qDpFiBfwUdMvbDnikTV5SQbvA==
X-Google-Smtp-Source: APXvYqz4/aPxUtBYYFhhUdM3X9ulHitssMLpGM56W+cLSMOPjXA6PEbPGkW8iDCHf9fDh+tYsDtyNw==
X-Received: by 2002:a1c:700a:: with SMTP id l10mr825543wmc.13.1553794525131;
        Thu, 28 Mar 2019 10:35:25 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id j11sm33103241wrw.85.2019.03.28.10.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:35:24 -0700 (PDT)
Date:   Thu, 28 Mar 2019 18:35:24 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/22] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190328173524.GR14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <f5af581e33b4976b84eae7c7788e3fde9adfa83c.1553532199.git.mkubecek@suse.cz>
 <2c29310b-a2a0-3867-a09f-51f2dc47ecd3@gmail.com>
 <20190328071853.GY26076@unicorn.suse.cz>
 <20190328134313.GO14297@nanopsycho>
 <20190328140428.GG26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328140428.GG26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 28, 2019 at 03:04:28PM CET, mkubecek@suse.cz wrote:
>On Thu, Mar 28, 2019 at 02:43:13PM +0100, Jiri Pirko wrote:
>> 
>> I don't like this. This should not be bitfield/set. This should be
>> simply nested array of enum values:
>> 
>> enum ethtool_link_mode {
>> 	ETHTOOL_LINK_MODE_10baseT_Half,
>> 	ETHTOOL_LINK_MODE_10baseT_Full,
>> 	ETHTOOL_LINK_MODE_100baseT_Half,
>> 	ETHTOOL_LINK_MODE_100baseT_Full,
>> 	ETHTOOL_LINK_MODE_1000baseT_Full,
>> };
>
>We already have such enum. The problem with your "no string" approach is
>that it requires all userspace applications to (1) keep this enum in

That is how it is usually done. UAPI defines ATTRS and values, userspace
assigns appropriate strings.


>sync with kernel and (2) maintain their our tables of names. Experience
>shows we are not very good and satisfying these conditions even for the
>one which should be best at keeping up.

Moreover, I think that speed, duplex and type should be sent
separatelly:

    ETHTOOL_A_LINK_MODE_LIST_OUR start nest
      ETHTOOL_A_LINK_MODE start nest
        ETHTOOL_A_LINK_MODE_SPEED = 100 /* this should be u64 */
	ETHTOOL_A_LINK_MODE_DUPLEX = ETHTOOL_LINK_MODE_DUPLEX_FULL
	ETHTOOL_A_LINK_MODE_TYPE = ETHTOOL_LINK_MODE_TYPE_BASET
      ETHTOOL_A_LINK_MODE start end
      ETHTOOL_A_LINK_MODE start nest
        ETHTOOL_A_LINK_MODE_SPEED = 10
	ETHTOOL_A_LINK_MODE_DUPLEX = ETHTOOL_LINK_MODE_DUPLEX_HALF
	ETHTOOL_A_LINK_MODE_TYPE = ETHTOOL_LINK_MODE_TYPE_BASET
      ETHTOOL_A_LINK_MODE start end
    ETHTOOL_A_LINK_MODE_LIST_PEER end nest

Does not really make sense to combine those 3 attributes together.


>
>> and then there should be 2 attrs:
>> ETHTOOL_A_LINK_MODE_LIST_OUR	/* nest */
>> ETHTOOL_A_LINK_MODE_LIST_PEER	/* nest */
>> ETHTOOL_A_LINK_MODE		/* u32 */
>> 
>> and then the message should look like:
>> 
>>    ETHTOOL_A_LINK_MODE_LIST_OUR start nest
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Half
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Full
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Half
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Full
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_1000baseT_Full
>>    ETHTOOL_A_LINK_MODE_LIST_OUR end nest
>>    ETHTOOL_A_LINK_MODE_LIST_PEER start nest
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Half
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_10baseT_Full
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Half
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_100baseT_Full
>>      ETHTOOL_A_LINK_MODE = ETHTOOL_LINK_MODE_1000baseT_Full
>>    ETHTOOL_A_LINK_MODE_LIST_PEER end nest
>> 
>> Nice and simple. No bits, no strings.
>
>A bit too simple, actually. You would need third nest to distinguish

It is just an example.


>supported and advertised modes. And for setting, you would also need two
>arrays if you want to set only some of the modes (unless you introduce
>something that would be similar to mine except for omitting the names).
>
>More important: you still didn't explain how is your "no strings"
>approach supposed to work for bit sets where userspace cannot possibly
>know the set of available flags (e.g. the private flags).

I know, that is a different part of this thread.

>
>Michal
