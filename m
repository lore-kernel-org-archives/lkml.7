Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D3C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA10218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="185ku0Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfGDIRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:17:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38724 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGDIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:17:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so5089957wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XH1XNSdwRWvb4UhP2BksO/qHU908eKTUW0fWRHawB/Q=;
        b=185ku0BsILAghMROrADuLcBBnGPoiprj9nHGRKOfuK47a5idfe2rH14OG39Qk64+0m
         1DFzJkffhFSVCh8oJ+eFOLKs9AkS4v9wqIWgwGlWPbvZyPt3lc1XTWVmz70KTbYOrvCG
         CukPB9JkaEBTZ09i3SbvAoU0AY43wYHuz5kvCF/ruJ2QlaJ9+xZOsfnSGTakIaqWErjz
         3rn4nZVPCSXsgZff1xgui5fIn3HKgWzSPmfHzR9hQA/Y6RuvXNFQrQ0bmB0fesrSKOH0
         jiW6h+aUvSid3ZPFH9HURUkubYAvtuE/7E4kfr24RGl6u4K2lDYSP4Pu6rSobYinsDvV
         y4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XH1XNSdwRWvb4UhP2BksO/qHU908eKTUW0fWRHawB/Q=;
        b=Ri9TPHlWowvXu9aJ8eVUIbHOHkipLCjukCmjgB5tqHwm+PdbdPz41f5xsSRtd9lg6E
         bgu9wdA1LfJtz7AyRw+8t/9MPKlIVkJdJwCzc9HbUKq0Nd4LMAh3KjE3LDoqAfQecGg0
         FTkl/SLLiE/+g5D8cnG5oDdgYeTjMjV5yFr4pNr8DKeWiN3iBE9E8ySRoiWzy3IiPWsd
         BPOxBMy5aluDFFYkpOSLCBK6gjUNX5ieqO9tZ9FqUYelccsIucPPZNI+WtJ216KxI9b8
         C78A4Z44dwF7bI3WB3zgi5tuBy1OhFMQCKKzTESHrlIuVXfo6kxqgARmgUiZ8jigDomU
         cwLg==
X-Gm-Message-State: APjAAAWI01FXlymKUaH3NyWElBM/naRNKlhyh3ZhJKyOwRdlIBFl+ThN
        5nJhXlHuc38VVq1CZEBVlqX/sA==
X-Google-Smtp-Source: APXvYqylnR+fBA//GggGkUmj6hYFyVpmLHwSQnbcrEHHMb9c3kfSri1IjOZuf7H2EDdp2qDQDL2yTQ==
X-Received: by 2002:a1c:345:: with SMTP id 66mr11741201wmd.8.1562228256006;
        Thu, 04 Jul 2019 01:17:36 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id o24sm7730053wmh.2.2019.07.04.01.17.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 01:17:35 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:17:35 +0200
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
Subject: Re: [PATCH net-next v6 10/15] ethtool: provide string sets with
 STRSET_GET request
Message-ID: <20190704081735.GI2250@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <3c30527bef64c030078a1e305613080bb372cbe6.1562067622.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c30527bef64c030078a1e305613080bb372cbe6.1562067622.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jul 02, 2019 at 01:50:29PM CEST, mkubecek@suse.cz wrote:

[...]


>@@ -87,6 +89,64 @@ enum {
> 	ETHTOOL_A_BITSET_MAX = (__ETHTOOL_A_BITSET_CNT - 1)

You don't need "()". Same for the others below.


> };
> 
>+/* string sets */
>+
>+enum {
>+	ETHTOOL_A_STRING_UNSPEC,
>+	ETHTOOL_A_STRING_INDEX,			/* u32 */
>+	ETHTOOL_A_STRING_VALUE,			/* string */
>+
>+	/* add new constants above here */
>+	__ETHTOOL_A_STRING_CNT,
>+	ETHTOOL_A_STRING_MAX = (__ETHTOOL_A_STRING_CNT - 1)
>+};
>+
>+enum {
>+	ETHTOOL_A_STRINGS_UNSPEC,
>+	ETHTOOL_A_STRINGS_STRING,		/* nest - _A_STRINGS_* */
>+
>+	/* add new constants above here */
>+	__ETHTOOL_A_STRINGS_CNT,
>+	ETHTOOL_A_STRINGS_MAX = (__ETHTOOL_A_STRINGS_CNT - 1)
>+};
>+
>+enum {
>+	ETHTOOL_A_STRINGSET_UNSPEC,
>+	ETHTOOL_A_STRINGSET_ID,			/* u32 */
>+	ETHTOOL_A_STRINGSET_COUNT,		/* u32 */
>+	ETHTOOL_A_STRINGSET_STRINGS,		/* nest - _A_STRINGS_* */
>+
>+	/* add new constants above here */
>+	__ETHTOOL_A_STRINGSET_CNT,
>+	ETHTOOL_A_STRINGSET_MAX = (__ETHTOOL_A_STRINGSET_CNT - 1)
>+};
>+
>+/* STRSET */
>+
>+enum {
>+	ETHTOOL_A_STRSET_UNSPEC,
>+	ETHTOOL_A_STRSET_HEADER,		/* nest - _A_HEADER_* */
>+	ETHTOOL_A_STRSET_STRINGSETS,		/* nest - _A_STRINGSETS_* */
>+
>+	/* add new constants above here */
>+	__ETHTOOL_A_STRSET_CNT,
>+	ETHTOOL_A_STRSET_MAX = (__ETHTOOL_A_STRSET_CNT - 1)
>+};
>+
>+enum {
>+	ETHTOOL_A_STRINGSETS_UNSPEC,
>+	ETHTOOL_A_STRINGSETS_STRINGSET,		/* nest - _A_STRINGSET_* */
>+
>+	/* add new constants above here */
>+	__ETHTOOL_A_STRINGSETS_CNT,
>+	ETHTOOL_A_STRINGSETS_MAX = (__ETHTOOL_A_STRINGSETS_CNT - 1)
>+};
>+

[...]	


>+	nla_for_each_nested(attr, nest, rem) {
>+		u32 id;
>+
>+		if (WARN_ONCE(nla_type(attr) != ETHTOOL_A_STRINGSETS_STRINGSET,
>+			      "unexpected attrtype %u in ETHTOOL_A_STRSET_STRINGSETS\n",
>+			      nla_type(attr)))
>+			return -EINVAL;
>+
>+		ret = strset_get_id(attr, &id, extack);
>+		if (ret < 0)
>+			return ret;
>+		if (ret >= ETH_SS_COUNT) {
>+			NL_SET_ERR_MSG_ATTR(extack, attr,
>+					    "unknown string set id");
>+			return -EOPNOTSUPP;
>+		}
>+
>+		data->req_ids |= (1U << id);

You don't need "()" here either.

[...]
