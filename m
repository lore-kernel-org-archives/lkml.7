Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4EF2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="KrtV0wbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfC1NcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:32:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52771 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfC1NcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:32:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so3606442wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0q2r53aKYUmVjk/D6UV35xslK67AC14YCtryKCiafY8=;
        b=KrtV0wbJF+CkFfmzL+RW7loSH/zJkKhUExhmCVQPZ84KB/JwDIo3z0tfy+mjUQJ4we
         YXhI55Pau7urEg3Axv2l0IklLQFAmxmiryAaQRM4gYItXanUKUVGoiay8IHD25bKRD/T
         EZyUCbRlBPE9+UkHLIjgyiHgPGhheEz5MnKuWhIEm7hIQdt7aExBH043J9tqwxEoab/S
         aRN3VElj9QaXBWR7Iop2smfCTanQJFsgNorCbr7CtxpOAaAfBcD186WW5pKm47kvSrbR
         ISHOqI0O/quah006gnoiqglV1ulTU/XFsYY4Upef/yT4knugquSzlgIxBxuHLzRGKmPw
         NdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0q2r53aKYUmVjk/D6UV35xslK67AC14YCtryKCiafY8=;
        b=bn3TLfvJqgodYr++d4RbWsRNDbt2hmcpMxvPvsgFFDBHj8B1he/+G0ibBBSrIvwvIZ
         X1+o5CIJw/NA04RWkQUlR2XeD/59+w6DHV5Gh125CaL2rmp4+zb/YCjUBvnGHWSrr1SQ
         lRfssirThud5ODT1LeXM/y6c4WKK+LvNzpsca5A5v6I65ep5PlQh/JBsKyj2rbCpvUc3
         OJGYhV8t9feqfBSYLoY+1lo862l2QDD+XPqC2CzCJqR+nxV6pz4VhgzUehUkmUQdo74b
         juZyxPYYZbJOth/jWRQKkMcVVLM7sYp6aGtbqJ5dkfq+bJEmFz9tZ+Gm1jjcV55+g55Z
         33OA==
X-Gm-Message-State: APjAAAVIU8jqgyfHrfN5tphz/sqGCmBPHoA34jFDMWwRxGTQ8wP9XE+t
        7iwUVWQfP12l7tLI1T+VGuiB3A==
X-Google-Smtp-Source: APXvYqxkSlh269JF0ezXugm6sKk9Rt2fh6o+j4ixkHTNXQ58iFy9+rHZpKDSoVx0dw/scroi0GK+1A==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr23075652wmc.71.1553779940349;
        Thu, 28 Mar 2019 06:32:20 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id h2sm45795944wro.11.2019.03.28.06.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:32:19 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:32:18 +0100
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
Message-ID: <20190328133218.GN14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <bda9c044a590ed61caa43c37d32b3b7f2b6326c5.1553532199.git.mkubecek@suse.cz>
 <20190327163507.GE14297@nanopsycho>
 <20190327215342.GU26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327215342.GU26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 10:53:42PM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 05:35:07PM +0100, Jiri Pirko wrote:
>> Mon, Mar 25, 2019 at 06:08:24PM CET, mkubecek@suse.cz wrote:
>> >Some parts of processing GET type requests and related notifications are
>> >independent of a command. Provide universal functions so that only four
>> >callbacks need to be defined for each command type:
>> >
>> >  parse_request() - parse incoming message
>> >  prepare_data()  - retrieve data from driver or NIC
>> >  reply_size()    - estimate reply message size
>> >  fill_reply()    - compose reply message
>> >
>> >These callback are defined in an instance of struct get_request_ops.
>> >
>> >Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>> 
>> [...]
>> 
>> >+/**
>> >+ * struct get_request_ops - unified handling of GET requests
>> >+ * @request_cmd:    command id for request (GET)
>> >+ * @reply_cmd:      command id for reply (SET)
>> >+ * @dev_attr:       attribute type for device specification
>> >+ * @data_size:      total length of data structure
>> >+ * @repdata_offset: offset of "reply data" part (struct common_reply_data)
>> >+ * @allow_nodev_do: do not fail if device is not specified for non-dump request
>> >+ * @parse_request:
>> >+ *	parse request message and fill request info; request info is zero
>> >+ *	initialized on entry except reply_data pointer (which is initialized)
>> >+ * @prepare_data:
>> >+ *	retrieve data needed to compose a reply message; reply data are zero
>> >+ *	initialized on entry except for @dev
>> >+ * @reply_size:
>> >+ *	return size of reply message payload without device specification;
>> >+ *	returned size may be bigger than actual reply size but it must suffice
>> >+ *	to hold the reply
>> >+ * @fill_reply:
>> >+ *	fill reply message payload using the data prepared by @prepare_data()
>> >+ * @cleanup
>> >+ *	(optional) called when data are no longer needed; use e.g. to free
>> >+ *	any additional data structures allocated in prepare_data() which are
>> >+ *	not part of the main structure
>> >+ *
>> >+ * Description of variable parts of GET request handling when using the unified
>> >+ * infrastructure. When used, a pointer to an instance of this structure is to
>> >+ * be added to &get_requests array, generic handlers ethnl_get_doit(),
>> >+ * ethnl_get_dumpit(), ethnl_get_start() and ethnl_get_done() used in
>> >+ * @ethnl_genl_ops and (optionally) ethnl_std_notify() as notification handler
>> >+ * in &ethnl_notify_handlers.
>> >+ */
>> >+struct get_request_ops {
>> 
>> First of all, please maintain the ethnl prefix. Not only here, but also
>> for other structs and functions (common_req_info, parse_*, etc).
>> 
>> But I must ask, why do we need this wrappers of ops around ops?
>> I believe it would be much nicer to use genl ops directly and do the
>> common work in pre_doit and and post_doit. Please see devlink.c for
>> examples.
>> 
>> Wrappers are unfortunately quite common in this patchset. Most of the
>> time, they do things much harder to follow and understand :(
>
>I'm a bit surprised by this position because so far my experience with
>linux networking code seemed to suggest that using simple wrappers and
>helpers is how things are supposed to be done. And while following a
>chain of such wrappers (often each in a different file) in a code I was
>reading for the first time could be frustrating at times, mostly I had
>to admit that this style has its merits. After all, genetlink itself is
>full of simple wrappers around netlink functions.
>
>Let me point out one thing: most of these helpers and wrappers are not
>artificial, they haven't been written in advance with an idea that they
>might be useful (the patch series does not, of course, reflect the
>development history); most of them were written when I realized I'm
>writing the same or almost the same code again and again.
>
>So when I caught myself writing
>
>  ... = nla_nest_start(skb, ... | NLA_F_NESTED);
>
>for the third or fourth time and I realized that every nla_nest_start()
>call in the code will have this bitwise or, I felt it would deserve
>a helper. (If I expected some objection, it was rather the optical
>asymmetry of ethnl_nest_start() being closed with nla_nest_end().)
>It would be much nicer to have it in nla_nest_start() but unfortunately
>it's too late for that.

Okay, this wrapper I can understand, but it certainly isn't ethnl
specific wrapper. It is generic, many others might use it:
$ git grep NLA_F_NESTED |grep nla_nest_start


>
>And it's exactly the same case with get_request_ops. For quite long
>(until after RFC v2), this framework didn't exist and code for get
>request processing (both doit and dumpit) and notifications was written
>separately for each message type. Realizing that big part of each new
>file is in fact an exact copy of the previous one with some string
>replacements and that it's going to be like that for most of the future
>files, that led me to identifying which parts are specific to message
>type and which are generic.
>
>If I have to get rid of get_request_ops, it will only result in having
>multiple copies of functions which would replace ethnl_get_doit(),
>ethnl_get_dumpit() and ethnl_std_notify(). They would be slightly
>simpler but would look the same except for "info" in one being replaced
>by "strset" in second, "settings" in third etc. Later, there would be
>one more copy for stats, one for tunables etc.
>
>I don't think the generic code can be handled just by pre_doit and
>post_doit as the generic and message specific part are interleaved and
>the generic parts are also different for do requests, dump requests and
>notifications.

What do you mean by "interleaved"? I guess you can make the attrs to be
formatted in the way it is not interleaved. Like what I suggested, to
have top-level generic attr enum and one of the generic attrs would nest
the cmd-specific attrs. That way, pre_doit can work with the generic
attrs, doit op can work with cmd-specific attrs. Similar to devlink
code.

>
>Michal
