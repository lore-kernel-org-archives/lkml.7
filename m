Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E5C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DCF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="PA+NlxB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfC0QfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:35:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfC0QfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:35:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so689456wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i5IITO1DwjDNioKMqYNjV8Fty9QJ3nAOpnfQpr9HkPI=;
        b=PA+NlxB6b0/m0yBONCqmRUaj6aoupfWiyWVHU900Heu0iWGfg1FXUwLwdM2LMa8+Mr
         MHBVha4zZl9LA+LwGUFQtQ1+W4KW3k0CDFXq4dxC2VH1FIi4UJhUOwF8PUqnPDDTbgmn
         2oFSvZmHMPjHBfI//Sa5V4PmbUFEo+d5CUL5/qQrRQqqNCtc7r/L+rBp4gABrwyoKGbD
         p+mG3P4zLIew7vbYC03AFc39r8b14QShlPY83dWxWyh648BFE8ydLTFZ5gmumA41el5W
         7gp49DiBtCGlzferfDpB+GD3BXvN9YzB+fsHr2sZpXLSNM9MGLj9Jwu60GyDgyl/WIbx
         pIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i5IITO1DwjDNioKMqYNjV8Fty9QJ3nAOpnfQpr9HkPI=;
        b=RCx6Oxv7Ma9fVW9WBPa4eTPVaBZCw/KGVY9PKum/lEuZ3FIjbsmZ/AiSUcpgxP+XCT
         3eN993w50eqqTIa7GSPKBw+Rjf9CLSGdsWDi3UUKAg8CwOPv4F83Ch4rw/ttPoPeMlFL
         sdG3jpOfv+9w84dTrNSmzqPU0IdRs19+NUNcKspbGq9ANbBbEC5PYoRUuaHVFJJw5YKV
         DiEDTG5wekG4NOc4RYEFmGlx/anhwGUvr0gJSVaTEYLF8+79Fk/h/hBHSQE7TXcHDeLE
         Y2iEu8wwHvgwIAyHgB6f1/rwMHozCIpcgNV57jO8XgO9UT4SUGKCOxE1ShX+4M9kd8E/
         TCJw==
X-Gm-Message-State: APjAAAWTFdnE/5glISG7VTD5wCTL/azEXIJH56MMNwidcvynxY4eK8FC
        0IZM7yq6V87Qs5NPGureM+SXsg==
X-Google-Smtp-Source: APXvYqxc0qGGNkzsiPRS8ZMqLeV9RRpCykClJhRE5kUTIyRM5tclHKD++8CpYEU+Q49jwQMokGNJhg==
X-Received: by 2002:a7b:c7d0:: with SMTP id z16mr19826782wmk.136.1553704508307;
        Wed, 27 Mar 2019 09:35:08 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id f9sm257186wmb.36.2019.03.27.09.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 09:35:07 -0700 (PDT)
Date:   Wed, 27 Mar 2019 17:35:07 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/22] ethtool: generic handlers for GET
 requests
Message-ID: <20190327163507.GE14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <bda9c044a590ed61caa43c37d32b3b7f2b6326c5.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda9c044a590ed61caa43c37d32b3b7f2b6326c5.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:24PM CET, mkubecek@suse.cz wrote:
>Some parts of processing GET type requests and related notifications are
>independent of a command. Provide universal functions so that only four
>callbacks need to be defined for each command type:
>
>  parse_request() - parse incoming message
>  prepare_data()  - retrieve data from driver or NIC
>  reply_size()    - estimate reply message size
>  fill_reply()    - compose reply message
>
>These callback are defined in an instance of struct get_request_ops.
>
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

[...]

>+/**
>+ * struct get_request_ops - unified handling of GET requests
>+ * @request_cmd:    command id for request (GET)
>+ * @reply_cmd:      command id for reply (SET)
>+ * @dev_attr:       attribute type for device specification
>+ * @data_size:      total length of data structure
>+ * @repdata_offset: offset of "reply data" part (struct common_reply_data)
>+ * @allow_nodev_do: do not fail if device is not specified for non-dump request
>+ * @parse_request:
>+ *	parse request message and fill request info; request info is zero
>+ *	initialized on entry except reply_data pointer (which is initialized)
>+ * @prepare_data:
>+ *	retrieve data needed to compose a reply message; reply data are zero
>+ *	initialized on entry except for @dev
>+ * @reply_size:
>+ *	return size of reply message payload without device specification;
>+ *	returned size may be bigger than actual reply size but it must suffice
>+ *	to hold the reply
>+ * @fill_reply:
>+ *	fill reply message payload using the data prepared by @prepare_data()
>+ * @cleanup
>+ *	(optional) called when data are no longer needed; use e.g. to free
>+ *	any additional data structures allocated in prepare_data() which are
>+ *	not part of the main structure
>+ *
>+ * Description of variable parts of GET request handling when using the unified
>+ * infrastructure. When used, a pointer to an instance of this structure is to
>+ * be added to &get_requests array, generic handlers ethnl_get_doit(),
>+ * ethnl_get_dumpit(), ethnl_get_start() and ethnl_get_done() used in
>+ * @ethnl_genl_ops and (optionally) ethnl_std_notify() as notification handler
>+ * in &ethnl_notify_handlers.
>+ */
>+struct get_request_ops {

First of all, please maintain the ethnl prefix. Not only here, but also
for other structs and functions (common_req_info, parse_*, etc).

But I must ask, why do we need this wrappers of ops around ops?
I believe it would be much nicer to use genl ops directly and do the
common work in pre_doit and and post_doit. Please see devlink.c for
examples.

Wrappers are unfortunately quite common in this patchset. Most of the
time, they do things much harder to follow and understand :(


>+	u8			request_cmd;
>+	u8			reply_cmd;
>+	u16			dev_attrtype;
>+	unsigned int		data_size;
>+	unsigned int		repdata_offset;
>+	bool			allow_nodev_do;
>+
>+	int (*parse_request)(struct common_req_info *req_info,
>+			     struct sk_buff *skb, struct genl_info *info,
>+			     const struct nlmsghdr *nlhdr);
>+	int (*prepare_data)(struct common_req_info *req_info,
>+			    struct genl_info *info);
>+	int (*reply_size)(const struct common_req_info *req_info);
>+	int (*fill_reply)(struct sk_buff *skb,
>+			  const struct common_req_info *req_info);
>+	void (*cleanup)(struct common_req_info *req_info);
>+};
>+
> #endif /* _NET_ETHTOOL_NETLINK_H */
>-- 
>2.21.0
>
