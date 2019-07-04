Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85BC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4FE2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="gZ4XEZxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfGDItS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:49:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56234 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfGDItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:49:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so4873710wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Opqt53sCXyUJn1dYGcaUv8QqkV6K1DcB1fwzBj1dwmA=;
        b=gZ4XEZxkgMW8Yw0Bz/cr8Thcx689u4KUu6s2K8mOLx18BKhblzhAwbNMg6C9sclyKb
         7TzAPwuwnThLEoPy8PVWUDUeoZ1rm1Wj7yW+miJ4/NCrsW9kWov49nKyEBwuQCdZVA+2
         RK/h2xqJYlQ76BfFjDn8AvJJ0XwflT3VnnelAmEAwprPBcluKYiw0AHcNc/ZbKgqsf9t
         +addGwqv2rTD/NCVmgG73StmjwHeEJRsyT1kvuwVSNXzcznEjk9lalZgCoHt5btErf24
         Er9Uh7XZDeAnlMR1+zedqy5sUxZcVuAfoAArTDWqA+MiuXKSuRItT2bEUg6RBlsnpR1S
         Z8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Opqt53sCXyUJn1dYGcaUv8QqkV6K1DcB1fwzBj1dwmA=;
        b=CErRqyowp/NT78Go9VwkTP5Tvg5BqHO6cflXAyw//B3Fhv4Z3v5BdxiWVmIDJZ0g+z
         IJDP6HI+44ckOOAe5f8tXxQl5cBq1Vj3mkie+WNMdxBMXSgWBLe58tvA3gh9y6Gkgume
         azONq5ZiBRdePcl4SY27882+3U0t+ldxe4Z2GdbwfqqQnDdQHnxY9y8lfQx2T+KwEXOk
         0TGfw38N3V44tL7zMMH3XwfrKyp+sxQ7RSGXO+opOp5HvZaAESLUQs23WhvFB3cXAZ2p
         uM0ViSUX2pqGN/+4Z0FTwiHLsp3gi6V32zhUPzi4v+yXIkebP5/n9iwaEm3+wmUQ/q28
         +7hA==
X-Gm-Message-State: APjAAAV9ejgzeuJubsH6069YbAgHUCL5ibl33R3e35iDBymXTP5azSWZ
        hPBuArJfsnLxet49JgFfFH8=
X-Google-Smtp-Source: APXvYqwtnYbOzxOXk6NyUec2QzT2mnnKsI8JZcQL5lVe4kpI7MU1EYEoR0UTqTUAdblTQOD1rBr/vg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr11788619wmg.7.1562230154732;
        Thu, 04 Jul 2019 01:49:14 -0700 (PDT)
Received: from localhost (ip-213-220-235-213.net.upcbroadband.cz. [213.220.235.213])
        by smtp.gmail.com with ESMTPSA id z25sm4811468wmf.38.2019.07.04.01.49.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 01:49:14 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:49:13 +0200
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
Subject: Re: [PATCH net-next v6 09/15] ethtool: generic handlers for GET
 requests
Message-ID: <20190704084913.GA18546@nanopsycho>
References: <cover.1562067622.git.mkubecek@suse.cz>
 <4faa0ce52dfe02c9cde5a46012b16c9af6764c5e.1562067622.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4faa0ce52dfe02c9cde5a46012b16c9af6764c5e.1562067622.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jul 02, 2019 at 01:50:24PM CEST, mkubecek@suse.cz wrote:

[...]


>+/* The structure holding data for unified processing GET requests consists of
>+ * two parts: request info and reply data. Request info is related to client
>+ * request and for dump request it stays constant through all processing;
>+ * reply data contains data for composing a reply message. When processing
>+ * a dump request, request info is filled only once but reply data is filled
>+ * from scratch for each reply message.
>+ *
>+ * +-----------------+-----------------+------------------+-----------------+
>+ * | common_req_info |  specific info  | ethnl_reply_data |  specific data  |
>+ * +-----------------+-----------------+------------------+-----------------+
>+ * |<---------- request info --------->|<----------- reply data ----------->|
>+ *
>+ * Request info always starts at offset 0 with struct ethnl_req_info which
>+ * holds information from parsing the common header. It may be followed by
>+ * other members for request attributes specific for current message type.
>+ * Reply data starts with struct ethnl_reply_data which may be followed by
>+ * other members holding data needed to compose a message.
>+ */
>+

[...]


>+/**
>+ * struct get_request_ops - unified handling of GET requests
>+ * @request_cmd:      command id for request (GET)
>+ * @reply_cmd:        command id for reply (GET_REPLY)
>+ * @hdr_attr:         attribute type for request header
>+ * @max_attr:         maximum (top level) attribute type
>+ * @data_size:        total length of data structure
>+ * @repdata_offset:   offset of "reply data" part (struct ethnl_reply_data)

For example, this looks quite scarry for me. You have one big chunk of
data (according to the scheme above) specific for cmd with reply starting
at arbitrary offset.



>+ * @request_policy:   netlink policy for message contents
>+ * @header_policy:    (optional) netlink policy for request header
>+ * @default_infomask: default infomask (to use if none specified)
>+ * @all_reqflags:     allowed request specific flags
>+ * @allow_nodev_do:   allow non-dump request with no device identification
>+ * @parse_request:
>+ *	Parse request except common header (struct ethnl_req_info). Common
>+ *	header is already filled on entry, the rest up to @repdata_offset
>+ *	is zero initialized. This callback should only modify type specific
>+ *	request info by parsed attributes from request message.
>+ * @prepare_data:
>+ *	Retrieve and prepare data needed to compose a reply message. Calls to
>+ *	ethtool_ops handlers should be limited to this callback. Common reply
>+ *	data (struct ethnl_reply_data) is filled on entry, type specific part
>+ *	after it is zero initialized. This callback should only modify the
>+ *	type specific part of reply data. Device identification from struct
>+ *	ethnl_reply_data is to be used as for dump requests, it iterates
>+ *	through network devices which common_req_info::dev points to the
>+ *	device from client request.
>+ * @reply_size:
>+ *	Estimate reply message size. Returned value must be sufficient for
>+ *	message payload without common reply header. The callback may returned
>+ *	estimate higher than actual message size if exact calculation would
>+ *	not be worth the saved memory space.
>+ * @fill_reply:
>+ *	Fill reply message payload (except for common header) from reply data.
>+ *	The callback must not generate more payload than previously called
>+ *	->reply_size() estimated.
>+ * @cleanup:
>+ *	Optional cleanup called when reply data is no longer needed. Can be
>+ *	used e.g. to free any additional data structures outside the main
>+ *	structure which were allocated by ->prepare_data(). When processing
>+ *	dump requests, ->cleanup() is called for each message.
>+ *
>+ * Description of variable parts of GET request handling when using the unified
>+ * infrastructure. When used, a pointer to an instance of this structure is to
>+ * be added to &get_requests array and generic handlers ethnl_get_doit(),
>+ * ethnl_get_dumpit(), ethnl_get_start() and ethnl_get_done() used in
>+ * @ethnl_genl_ops
>+ */
>+struct get_request_ops {
>+	u8			request_cmd;
>+	u8			reply_cmd;
>+	u16			hdr_attr;
>+	unsigned int		max_attr;
>+	unsigned int		data_size;
>+	unsigned int		repdata_offset;
>+	const struct nla_policy *request_policy;
>+	const struct nla_policy *header_policy;
>+	u32			default_infomask;
>+	u32			all_reqflags;
>+	bool			allow_nodev_do;
>+
>+	int (*parse_request)(struct ethnl_req_info *req_info,
>+			     struct nlattr **tb,
>+			     struct netlink_ext_ack *extack);
>+	int (*prepare_data)(struct ethnl_req_info *req_info,
>+			    struct genl_info *info);
>+	int (*reply_size)(const struct ethnl_req_info *req_info);
>+	int (*fill_reply)(struct sk_buff *skb,
>+			  const struct ethnl_req_info *req_info);
>+	void (*cleanup)(struct ethnl_req_info *req_info);
>+};
>+
> #endif /* _NET_ETHTOOL_NETLINK_H */
>-- 
>2.22.0
>
