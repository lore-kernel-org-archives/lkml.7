Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70AFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3020700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfC0Vxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:53:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:54774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfC0Vxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:53:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 865E2AC23;
        Wed, 27 Mar 2019 21:53:47 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 9D803E1404; Wed, 27 Mar 2019 22:53:42 +0100 (CET)
Date:   Wed, 27 Mar 2019 22:53:42 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 10/22] ethtool: generic handlers for GET
 requests
Message-ID: <20190327215342.GU26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <bda9c044a590ed61caa43c37d32b3b7f2b6326c5.1553532199.git.mkubecek@suse.cz>
 <20190327163507.GE14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327163507.GE14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:35:07PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:24PM CET, mkubecek@suse.cz wrote:
> >Some parts of processing GET type requests and related notifications are
> >independent of a command. Provide universal functions so that only four
> >callbacks need to be defined for each command type:
> >
> >  parse_request() - parse incoming message
> >  prepare_data()  - retrieve data from driver or NIC
> >  reply_size()    - estimate reply message size
> >  fill_reply()    - compose reply message
> >
> >These callback are defined in an instance of struct get_request_ops.
> >
> >Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> [...]
> 
> >+/**
> >+ * struct get_request_ops - unified handling of GET requests
> >+ * @request_cmd:    command id for request (GET)
> >+ * @reply_cmd:      command id for reply (SET)
> >+ * @dev_attr:       attribute type for device specification
> >+ * @data_size:      total length of data structure
> >+ * @repdata_offset: offset of "reply data" part (struct common_reply_data)
> >+ * @allow_nodev_do: do not fail if device is not specified for non-dump request
> >+ * @parse_request:
> >+ *	parse request message and fill request info; request info is zero
> >+ *	initialized on entry except reply_data pointer (which is initialized)
> >+ * @prepare_data:
> >+ *	retrieve data needed to compose a reply message; reply data are zero
> >+ *	initialized on entry except for @dev
> >+ * @reply_size:
> >+ *	return size of reply message payload without device specification;
> >+ *	returned size may be bigger than actual reply size but it must suffice
> >+ *	to hold the reply
> >+ * @fill_reply:
> >+ *	fill reply message payload using the data prepared by @prepare_data()
> >+ * @cleanup
> >+ *	(optional) called when data are no longer needed; use e.g. to free
> >+ *	any additional data structures allocated in prepare_data() which are
> >+ *	not part of the main structure
> >+ *
> >+ * Description of variable parts of GET request handling when using the unified
> >+ * infrastructure. When used, a pointer to an instance of this structure is to
> >+ * be added to &get_requests array, generic handlers ethnl_get_doit(),
> >+ * ethnl_get_dumpit(), ethnl_get_start() and ethnl_get_done() used in
> >+ * @ethnl_genl_ops and (optionally) ethnl_std_notify() as notification handler
> >+ * in &ethnl_notify_handlers.
> >+ */
> >+struct get_request_ops {
> 
> First of all, please maintain the ethnl prefix. Not only here, but also
> for other structs and functions (common_req_info, parse_*, etc).
> 
> But I must ask, why do we need this wrappers of ops around ops?
> I believe it would be much nicer to use genl ops directly and do the
> common work in pre_doit and and post_doit. Please see devlink.c for
> examples.
> 
> Wrappers are unfortunately quite common in this patchset. Most of the
> time, they do things much harder to follow and understand :(

I'm a bit surprised by this position because so far my experience with
linux networking code seemed to suggest that using simple wrappers and
helpers is how things are supposed to be done. And while following a
chain of such wrappers (often each in a different file) in a code I was
reading for the first time could be frustrating at times, mostly I had
to admit that this style has its merits. After all, genetlink itself is
full of simple wrappers around netlink functions.

Let me point out one thing: most of these helpers and wrappers are not
artificial, they haven't been written in advance with an idea that they
might be useful (the patch series does not, of course, reflect the
development history); most of them were written when I realized I'm
writing the same or almost the same code again and again.

So when I caught myself writing

  ... = nla_nest_start(skb, ... | NLA_F_NESTED);

for the third or fourth time and I realized that every nla_nest_start()
call in the code will have this bitwise or, I felt it would deserve
a helper. (If I expected some objection, it was rather the optical
asymmetry of ethnl_nest_start() being closed with nla_nest_end().)
It would be much nicer to have it in nla_nest_start() but unfortunately
it's too late for that.

And it's exactly the same case with get_request_ops. For quite long
(until after RFC v2), this framework didn't exist and code for get
request processing (both doit and dumpit) and notifications was written
separately for each message type. Realizing that big part of each new
file is in fact an exact copy of the previous one with some string
replacements and that it's going to be like that for most of the future
files, that led me to identifying which parts are specific to message
type and which are generic.

If I have to get rid of get_request_ops, it will only result in having
multiple copies of functions which would replace ethnl_get_doit(),
ethnl_get_dumpit() and ethnl_std_notify(). They would be slightly
simpler but would look the same except for "info" in one being replaced
by "strset" in second, "settings" in third etc. Later, there would be
one more copy for stats, one for tunables etc.

I don't think the generic code can be handled just by pre_doit and
post_doit as the generic and message specific part are interleaved and
the generic parts are also different for do requests, dump requests and
notifications.

Michal
