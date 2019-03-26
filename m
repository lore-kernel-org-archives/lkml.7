Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0308320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfCZOT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:19:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfCZOT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:19:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEE65AF93;
        Tue, 26 Mar 2019 14:19:56 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id E7DB0E1404; Tue, 26 Mar 2019 15:19:55 +0100 (CET)
Date:   Tue, 26 Mar 2019 15:19:55 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/22] ethtool: helper functions for netlink
 interface
Message-ID: <20190326141955.GL26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <043188fe4776b9420a11116af5e6bad8925b9ee7.1553532199.git.mkubecek@suse.cz>
 <20190326123815.GG2230@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326123815.GG2230@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:38:15PM +0100, Jiri Pirko wrote:
> Mon, Mar 25, 2019 at 06:08:12PM CET, mkubecek@suse.cz wrote:
> >+/* device specification */
> >+
> >+enum {
> >+	ETHA_DEV_UNSPEC,
> 
> ETHNL/ETHA looks odd.
> I would prefer prefix "ETHTOOL_* for everything in uapi:
> ETHTOOL_CMD_* for commands.
> ETHTOOL_ATTR_* for attributes.
> 
> Looks much nicer.

Even with ETHA_ prefix, there are places where having to fit into
80 columns makes the code hard to read. ETHTOOL_ATTR_ would make it
even harder.

> >+static const struct nla_policy dev_policy[ETHA_DEV_MAX + 1] = {
> 
> ethnl_dev_policy. Please maintain the namespace if possible.
> "dev_policy" looks way too generic if anyone sees it in the code.

OK
> >+	[ETHA_DEV_UNSPEC]	= { .type = NLA_REJECT },
> >+	[ETHA_DEV_INDEX]	= { .type = NLA_U32 },
> >+	[ETHA_DEV_NAME]		= { .type = NLA_NUL_STRING,
> >+				    .len = IFNAMSIZ - 1 },
> >+};
> >+
> >+/**
> >+ * ethnl_dev_get() - get device identified by nested attribute
> >+ * @info: genetlink info (also used for extack error reporting)
> >+ * @nest: nest attribute with device identification
> >+ *
> >+ * Finds the network device identified by ETHA_DEV_INDEX (ifindex) or
> >+ * ETHA_DEV_NAME (name) attributes in a nested attribute @nest. If both
> >+ * are supplied, they must identify the same device. If successful, takes
> >+ * a reference to the device which is to be released by caller.
> >+ *
> >+ * Return: pointer to the device if successful, ERR_PTR(err) on error
> >+ */
> >+struct net_device *ethnl_dev_get(struct genl_info *info, struct nlattr *nest)
> 
> I wonder, why you have this in nested attr? Aren't ifindex/ifname always
> used as a handle for commands/notifications? Would be just in toplevel
> (see devlink/nl80211)

It makes things only slightly easier now but I would like to make the
API as future proof as possible. If something needs to be added later
(e.g. netns id) or something else changes (e.g. 64-bit ifindex), only
one enum and these two helpers would need to be adjusted.

> >+	if (!nest) {
> >+		ETHNL_SET_ERRMSG(info,
> >+				 "mandatory device identification missing");
> 
> No need to wrap.

OK

> >+	ret = nla_parse_nested_strict(tb, ETHA_DEV_MAX, nest, dev_policy,
> >+				      info->extack);
> >+	if (ret < 0)
> 
> "if (ret)" is enough. "Returns 0 on success or a negative error code."

OK

> >+			if (strncmp(dev->name, nl_name, IFNAMSIZ)) {
> >+				dev_put(dev);
> >+				ETHNL_SET_ERRMSG(info,
> >+						 "ifindex and ifname do not match");
> 
> No need to wrap.

OK

> >+/**
> >+ * ethnl_fill_dev() - Put device identification nest into a message
> >+ * @msg:      skb with the message
> >+ * @dev:      network device to describe
> >+ * @attrtype: attribute type to use for the nest
> >+ *
> >+ * Create a nested attribute with attributes describing given network device.
> >+ * Clean up on error.
> >+ *
> >+ * Return: 0 on success, error value (-EMSGSIZE only) on error
> >+ */
> >+int ethnl_fill_dev(struct sk_buff *msg, struct net_device *dev, u16 attrtype)
> >+{
> >+	struct nlattr *nest;
> >+	int ret = -EMSGSIZE;
> >+
> >+	nest = ethnl_nest_start(msg, attrtype);
> >+	if (!nest)
> >+		return -EMSGSIZE;
> >+
> >+	if (nla_put_u32(msg, ETHA_DEV_INDEX, (u32)dev->ifindex))
> >+		goto err;
> >+	if (nla_put_string(msg, ETHA_DEV_NAME, dev->name))
> >+		goto err;
> >+
> >+	nla_nest_end(msg, nest);
> >+	return 0;
> >+err:
> Usually this label is called "nla_put_failure". Same for the rest.
> "err" could be confused with error return variable.
> 
> have "ret = -EMSGSIZE" here. Easier to follow the error path.

OK

> >+	nla_nest_cancel(msg, nest);
> >+	return ret;
> >+}
> >+
> >+/**
> >+ * ethnl_reply_init() - Create skb for a reply and fill device identification
> >+ * @payload: payload length (without netlink and genetlink header)
> >+ * @dev:     device the reply is about (may be null)
> >+ * @cmd:     ETHNL_CMD_* command for reply
> >+ * @info:    genetlink info of the received packet we respond to
> >+ * @ehdrp:   place to store payload pointer returned by genlmsg_new()
> >+ *
> >+ * Return: pointer to allocated skb on success, NULL on error
> >+ */
> >+struct sk_buff *ethnl_reply_init(size_t payload, struct net_device *dev, u8 cmd,
> >+				 u16 dev_attrtype, struct genl_info *info,
> >+				 void **ehdrp)
> >+{
> >+	struct sk_buff *rskb;
> 
> Could be just "skb", or "msg". You have "msg" in ethnl_fill_dev().
> Please have it consistent.

OK

> >+	rskb = genlmsg_new(payload, GFP_KERNEL);
> >+	if (!rskb) {
> >+		ETHNL_SET_ERRMSG(info,
> >+				 "failed to allocate reply message");
> 
> No need to wrap.

OK

> >+		int ret = ethnl_fill_dev(rskb, dev, dev_attrtype);
> >+
> >+		if (ret < 0)
> 
> "if (ret)" is enough.

OK

> >+
> >+#define ETHNL_SET_ERRMSG(info, msg) \
> >+	do { if (info) GENL_SET_ERR_MSG(info, msg); } while (0)
> 
> Why do you need this macro? Can info be null?

The same functions are used for generating replies to GET requests (info
is not null) and notifications (info is null, no extack).

> In general, macros like this should be avoided.

At the expense of repeating the same patterns. In this case it would be
acceptable but it would mean one more indentation level for lines with
the error/warning messages.

> >+static inline int ethnl_str_size(const char *s)
> >+{
> >+	return nla_total_size(strlen(s) + 1);
> 
> This looks like more generic helper, not tight to ethtool.

OK

> >+static inline int ethnl_str_ifne_size(const char *s)
> 
> Eh? "ifne"? What is this good for?

It's for "if not empty". Structures like ethtool_drvinfo use fixed size
char arrays for strings where empty string means the information is not
available. So if the string is empty, netlink attribute is omitted.

> >+{
> >+	return s[0] ? ethnl_str_size(s) : 0;
> >+}
> >+
> >+static inline int ethnl_put_str_ifne(struct sk_buff *skb, int attrtype,
> >+				     const char *s)
> >+{
> >+	if (!s[0])
> >+		return 0;
> >+	return nla_put_string(skb, attrtype, s);
> 
> I don't like helpers like this. Do the check in the caller and put or
> not put the string there. It's a single if.

OK


> >+static inline struct nlattr *ethnl_nest_start(struct sk_buff *skb,
> >+					      int attrtype)
> >+{
> >+	return nla_nest_start(skb, attrtype | NLA_F_NESTED);
> 
> Please use nla_nest_start directly and avoid helpers like this.

OK. It's one more thing to check (and forget) in many places, though.

> >+static inline int ethnlmsg_parse(const struct nlmsghdr *nlh,
> >+				 struct nlattr *tb[], int maxtype,
> >+				 const struct nla_policy *policy,
> >+				 struct genl_info *info)
> >+{
> >+	return nlmsg_parse_strict(nlh, GENL_HDRLEN, tb, maxtype, policy,
> >+				  info ? info->extack : NULL);
> 
> Same thing, please use nlmsg_parse_strict directly.

OK

> >+/* ethnl_update_* return true if the value is changed */
> >+static inline bool ethnl_update_u32(u32 *dst, struct nlattr *attr)
> >+{
> >+	u32 val;
> >+
> >+	if (!attr)
> >+		return false;
> >+	val = nla_get_u32(attr);
> >+	if (*dst == val)
> >+		return false;
> >+
> >+	*dst = val;
> >+	return true;
> >+}
> >+
> >+static inline bool ethnl_update_u8(u8 *dst, struct nlattr *attr)
> >+{
> >+	u8 val;
> >+
> >+	if (!attr)
> >+		return false;
> >+	val = nla_get_u8(attr);
> >+	if (*dst == val)
> >+		return false;
> >+
> >+	*dst = val;
> >+	return true;
> >+}
> >+
> >+/* update u32 value used as bool from NLA_U8 */
> >+static inline bool ethnl_update_bool32(u32 *dst, struct nlattr *attr)
> >+{
> >+	u8 val;
> >+
> >+	if (!attr)
> >+		return false;
> >+	val = !!nla_get_u8(attr);
> >+	if (!!*dst == val)
> >+		return false;
> >+
> >+	*dst = val;
> >+	return true;
> >+}
> >+
> >+static inline bool ethnl_update_binary(u8 *dst, unsigned int len,
> >+				       struct nlattr *attr)
> >+{
> >+	if (!attr)
> >+		return false;
> >+	if (nla_len(attr) < len)
> >+		len = nla_len(attr);
> >+	if (!memcmp(dst, nla_data(attr), len))
> >+		return false;
> >+
> >+	memcpy(dst, nla_data(attr), len);
> >+	return true;
> >+}
> >+
> >+static inline bool ethnl_update_bitfield32(u32 *dst, struct nlattr *attr)
> >+{
> >+	struct nla_bitfield32 change;
> >+	u32 newval;
> >+
> >+	if (!attr)
> >+		return false;
> >+	change = nla_get_bitfield32(attr);
> >+	newval = (*dst & ~change.selector) | (change.value & change.selector);
> >+	if (*dst == newval)
> >+		return false;
> >+
> >+	*dst = newval;
> >+	return true;
> >+}
> 
> I don't understand puspose of these "update" helper functions. Try to
> avoid them. In general, please try to avoid wrappers around netlink api.

The purpose is to update a value according to a request attribute (if
present) and tell caller if the value was actually modified. They are
used like e.g.

	mod = false;
	if (ethnl_update_u32(&data.rx_pending, tb[ETHA_RING_RX_PENDING]))
		mod = true;
	if (ethnl_update_u32(&data.rx_mini_pending,
			     tb[ETHA_RING_RX_MINI_PENDING]))
		mod = true;
	if (ethnl_update_u32(&data.rx_jumbo_pending,
			     tb[ETHA_RING_RX_JUMBO_PENDING]))
		mod = true;
	if (ethnl_update_u32(&data.tx_pending, tb[ETHA_RING_TX_PENDING]))
		mod = true;

	if (!mod)
		return 0;
	/* call ethtool_ops handler and send notification */

so that we can omit calling the handler and sending a notification if
the request was no-op. Expanding the helpers here would make the code
needlessly complicated and error prone.

> >+static inline void warn_partial_info(struct genl_info *info)
> >+{
> >+	ETHNL_SET_ERRMSG(info, "not all requested data could be retrieved");
> >+}
> >+
> >+/* Check user privileges explicitly to allow finer access control based on
> >+ * context of the request or hiding part of the information from unprivileged
> >+ * users
> >+ */
> >+static inline bool ethnl_is_privileged(struct sk_buff *skb)
> >+{
> >+	struct net *net = sock_net(skb->sk);
> >+
> >+	return netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN);
> 
> Same here.

It's still the same, helpers allow replacing repeating code patterns
with just saying what you are doing. But this one is called only from
one place so I can live without it.

> >+}
> >+
> >+/* total size of ETHA_*_DEV nested attribute; this is an upper estimate so that
> >+ * we do not need to hold RTNL longer than necessary to prevent rename between
> >+ * estimating the size and composing the message
> >+ */
> >+static inline unsigned int dev_ident_size(void)
> 
> You are missing "ethnl_" prefix.

OK

Michal
