Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC30C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F68A214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 05:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="YD1Pf64k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJKF74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 01:59:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53312 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKF7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 01:59:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so9066974wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E623mGQzQk4H0tAY9GdfF81TR0YLSYt5QE21p1KLml8=;
        b=YD1Pf64kzWJbUegZO8vee8L+gURtVKZvVf7aqAQa8CxBI18YztHqkfzbXaXhmXfRA3
         CQiOELsj4RAd+fhZd1E6G+h98sJcf8/5DsucDn1fPJ+AGYQ/x1yKZRMwC7mI0TZ6ZUbn
         65l2qIhYtYS0bfuxaDnj0sesubNmoMkLwlydnZIBbw5LQymLfNblHSfYEMbwRbv+RtZx
         M3px1doS1vk6mcf8OpsOTcIuSLyi/nWqoCZd3LWd0+KNcYUStehLlK8qqKXReg/Ux8dw
         vxJgLSl0GxPH/ESAF76C/4VTomq7NBF6TnSbOCDNgh2CC7YTqtML5DbG6guinwrvP7+E
         ANKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E623mGQzQk4H0tAY9GdfF81TR0YLSYt5QE21p1KLml8=;
        b=i8mfNdCOc5r3l/8HB1+PiOgUwL6LiibDupvNSeg4ASoXy4LCAMHeD0sdk4+wk6tmcj
         RDGF4PRi3ItH6dmkVvC6de6Bcnz87ZpOKjiSrOPzxnOjZuPOzXAIPQL2/XcCiuoOg1JS
         D8BhvFdkMZCtrvrTVAKPlcjRXVL0l4ng0HXcY0Y0H5wJz0ZwYVTIr3ZBUh0IF9fR5fZ8
         ia7N7Em8H7ZgsG0VmAxk6HFxD65O3zmnnapdLRk3cCtUU/78rGK5X8n3oEzBWRisZS3u
         AMA8k3s4lUefHF2gMOias1BaiPq8PkXLEvdtXElLvDh1Ti/0fMEPrSvtgu8zpkxp/6lK
         Kr/Q==
X-Gm-Message-State: APjAAAUeCRXxKBnUG1VdioQHq8CpWjylBytemJCqslJxAJRbwGXw+4pX
        CMZMCYwvFL9OnVPBnzBioTbWmQ==
X-Google-Smtp-Source: APXvYqzfhb28ZOYa+Vc0sIuzldCh/qOUrxS0FesYM+B+CBIQ1Ng7rqeLckWB4CDZFRn97jom6KKulQ==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr1755530wma.39.1570773593211;
        Thu, 10 Oct 2019 22:59:53 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id v11sm6923371wml.30.2019.10.10.22.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 22:59:52 -0700 (PDT)
Date:   Fri, 11 Oct 2019 07:59:51 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 14/17] ethtool: set link settings with
 LINKINFO_SET request
Message-ID: <20191011055951.GD2901@nanopsycho>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <aef31ba798d1cfa2ae92d333ad1547f4b528ffa8.1570654310.git.mkubecek@suse.cz>
 <20191010153754.GA2901@nanopsycho>
 <20191010193044.GG22163@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010193044.GG22163@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 10, 2019 at 09:30:44PM CEST, mkubecek@suse.cz wrote:
>On Thu, Oct 10, 2019 at 05:37:54PM +0200, Jiri Pirko wrote:
>> Wed, Oct 09, 2019 at 10:59:43PM CEST, mkubecek@suse.cz wrote:
>> >Implement LINKINFO_SET netlink request to set link settings queried by
>> >LINKINFO_GET message.
>> >
>> >Only physical port, phy MDIO address and MDI(-X) control can be set,
>> >attempt to modify MDI(-X) status and transceiver is rejected.
>> >
>> >When any data is modified, ETHTOOL_MSG_LINKINFO_NTF message in the same
>> >format as reply to LINKINFO_GET request is sent to notify userspace about
>> >the changes. The same notification is also sent when these settings are
>> >modified using the ioctl interface.
>> >
>> 
>> It is a bit confusing and harder to follow when you have set and notify
>> code in the same patch. Could you please split?
>
>As the notification is composed and sent by ethnl_std_notify() with help
>of the callback functions used to generate the reply to GET request, the
>only notification related changes in this patch are the three calls to
>ethtool_notify() (one in netlink code, two in ioctl code) and the entry
>added to ethnl_notify_handlers[].
>
>But I have no objection to splitting these out into a separate patch,
>except for having sacrifice some of the patches actually implementing
>something so that the series doesn't get too long.

Please split.


>
>> 
>> [...]
>> 
>> 
>> >+/* LINKINFO_SET */
>> >+
>> >+static const struct nla_policy linkinfo_hdr_policy[ETHTOOL_A_HEADER_MAX + 1] = {
>> >+	[ETHTOOL_A_HEADER_UNSPEC]		= { .type = NLA_REJECT },
>> >+	[ETHTOOL_A_HEADER_DEV_INDEX]		= { .type = NLA_U32 },
>> >+	[ETHTOOL_A_HEADER_DEV_NAME]		= { .type = NLA_NUL_STRING,
>> >+						    .len = IFNAMSIZ - 1 },
>> >+	[ETHTOOL_A_HEADER_GFLAGS]		= { .type = NLA_U32 },
>> >+	[ETHTOOL_A_HEADER_RFLAGS]		= { .type = NLA_REJECT },
>> >+};
>> 
>> This is what I was talking about in the other email. These common attrs
>> should have common policy and should be parsed by generic netlink code
>> by default and be available for ethnl_set_linkinfo() in info->attrs.
>
>NLA_REJECT for ETHTOOL_A_HEADER_RFLAGS is probably an overkill here. If
>I just check that client does not set flags we do not know, I can have
>one universal header policy as well. I'll probably do that.
>
>> >+int ethnl_set_linkinfo(struct sk_buff *skb, struct genl_info *info)
>> >+{
>> >+	struct nlattr *tb[ETHTOOL_A_LINKINFO_MAX + 1];
>> >+	struct ethtool_link_ksettings ksettings = {};
>> >+	struct ethtool_link_settings *lsettings;
>> >+	struct ethnl_req_info req_info = {};
>> >+	struct net_device *dev;
>> >+	bool mod = false;
>> >+	int ret;
>> >+
>> >+	ret = nlmsg_parse(info->nlhdr, GENL_HDRLEN, tb,
>> >+			  ETHTOOL_A_LINKINFO_MAX, linkinfo_set_policy,
>> >+			  info->extack);
>> 
>> Yeah, genl code should do this parse..
>
>Not really. It would only parse the top level - which, in your design,
>would only be the common header. In other words, it would do what is now
>done by the call to nla_parse_nested() inside ethnl_parse_header(). For
>equivalent of this parse, you would still have to call your own
>nla_parse_nested() on the "request specific data" nested attribute.

Okay, the parse would stay, you are correct.


>
>> >+	if (ret < 0)
>> >+		return ret;
>> >+	ret = ethnl_parse_header(&req_info, tb[ETHTOOL_A_LINKINFO_HEADER],
>> >+				 genl_info_net(info), info->extack,
>> >+				 linkinfo_hdr_policy, true);
>> 
>> and pre_doit should do this one.
>
>...and also (each) start(). Which means you would either duplicate the
>code or introduce the same helper. All you would save would be that one
>call of nla_parse_nested() in ethnl_parse_header().

Sure, it could be a same helper called fro pre_doit and start. No
problem.


>
>> >+
>> >+	ret = 0;
>> >+	if (mod) {
>> 
>> 	if (!mod)
>> 		goto out_ops;
>> 
>> ?
>
>OK
>
>> >+		ret = dev->ethtool_ops->set_link_ksettings(dev, &ksettings);
>> >+		if (ret < 0)
>> >+			GENL_SET_ERR_MSG(info, "link settings update failed");
>> >+		else
>> >+			ethtool_notify(dev, ETHTOOL_MSG_LINKINFO_NTF, NULL);
>> >+	}
>> >+
>> >+out_ops:
>> >+	ethnl_after_ops(dev);
>> >+out_rtnl:
>> >+	rtnl_unlock();
>> >+	dev_put(dev);
>> >+	return ret;
>> >+}
>...
>> >@@ -683,6 +688,7 @@ typedef void (*ethnl_notify_handler_t)(struct net_device *dev, unsigned int cmd,
>> > 				       const void *data);
>> > 
>> > static const ethnl_notify_handler_t ethnl_notify_handlers[] = {
>> >+	[ETHTOOL_MSG_LINKINFO_NTF]	= ethnl_std_notify,
>> 
>> Correct me if I'm wrong, but this is the only notification I found in
>> this patchset. Do you expect other then ethnl_std_notify() handler?
>> Bacause otherwise this can ba simplified down to just a single table
>> similar you have for GET.
>
>Yes, there will be other handlers; ethnl_std_notify() can only handle
>the simplest (even if most common) type of notification where caller
>does not pass any information except the device, the notification
>message is exactly the same as reply to corresponding GET request would
>be and that GET request does not have any attributes (so that it can be
>handled with ethnl_get_doit()).
>
>There will be notifications which will need their own handlers, e.g. all
>notifications triggered by an action request (e.g. renegotiation or
>device reset) or notifications triggered by "ethtool -X".
>
>Michal
