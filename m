Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A727C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5652077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbfDYUjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:39:51 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33120 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfDYUjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:39:51 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Apr 2019 16:39:50 EDT
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x3PKYOhI015631;
        Thu, 25 Apr 2019 22:34:24 +0200
Date:   Thu, 25 Apr 2019 22:34:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Marco Davids <mdavids@forfun.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: How to turn off IPv4 without disabling IPv6
Message-ID: <20190425203424.GA14855@1wt.eu>
References: <85740792-d244-ba03-3e72-fb576ddcb7dc@forfun.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85740792-d244-ba03-3e72-fb576ddcb7dc@forfun.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 06:42:52PM +0200, Marco Davids wrote:
> Op Thu, Apr 25, 2019 at 13:22, Nico Schottelius wrote:
> > if I cannot turn off IPv4, I cannot test what needs to be fixed.
> 
> You know what? I actually agree with Nico on this.
> 
> It's 2019 and the adoption of IPv6 is actually gaining momentum (at last).
> 
> This is absolutely the time to seriously start thinking about unbundling
> IP-stacks the kernel, so that IPv4 can be truly disabled at compile time.
> 
> That will allow for further testing and fixes, just as Nico suggests.

While I can understand the value in doing this, I think that there's
much more value in being able to disable it at run time, precisely
because if you have to reboot to a different kernel for each and every
minor application issue you meet, it will take ages before you converge
to something usable.

Probably that for such tests instead you should use a sysctl to allow/deny
IPv4 socket creation. It should be more than enough for program validation.
Something like the following code (not even compile-tested) could possibly
be sufficient.

Just my two cents,
Willy

-------------

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 104a666..aa9ac80 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -83,6 +83,8 @@ struct netns_ipv4 {
 	struct xt_table		*nat_table;
 #endif
 
+	int sysctl_disable;
+
 	int sysctl_icmp_echo_ignore_all;
 	int sysctl_icmp_echo_ignore_broadcasts;
 	int sysctl_icmp_ignore_bogus_error_responses;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index eab3ebd..0784c41 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -255,6 +255,9 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	int try_loading_module = 0;
 	int err;
 
+	if (net->ipv4.sysctl_disable)
+		return -EAFNOSUPPORT;
+
 	if (protocol < 0 || protocol >= IPPROTO_MAX)
 		return -EINVAL;
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index eeb4041..73a7ead 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -555,6 +555,13 @@ static struct ctl_table ipv4_table[] = {
 
 static struct ctl_table ipv4_net_table[] = {
 	{
+		.procname	= "disable",
+		.data		= &init_net.ipv4.sysctl_disable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{
 		.procname	= "icmp_echo_ignore_all",
 		.data		= &init_net.ipv4.sysctl_icmp_echo_ignore_all,
 		.maxlen		= sizeof(int),
