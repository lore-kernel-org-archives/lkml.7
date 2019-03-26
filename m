Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACECC20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfCZKbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZKbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:31:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93773ADE7;
        Tue, 26 Mar 2019 10:31:21 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 52EE5E1404; Tue, 26 Mar 2019 11:31:15 +0100 (CET)
Date:   Tue, 26 Mar 2019 11:31:15 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/22] rtnetlink: provide permanent hardware
 address in RTM_NEWLINK
Message-ID: <20190326103115.GI26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <16ffb1fbfa8f54de587ac52f4ff95e5034c590b4.1553532199.git.mkubecek@suse.cz>
 <20190326100836.GA2230@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326100836.GA2230@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:08:36AM +0100, Jiri Pirko wrote:
> 
> I don't think we should put permaddr if driver did not set it. 2
> solutions:
> 1) provide a helper that driver will use to set the perm_addr. This
>    helper sets a "valid bit". Then you only put IFLA_PERM_ADDRESS
>    in case the "valid bit" is set.
> 2) Assuming that no driver would set permaddr to all zeroes,
>    don't put IFLA_PERM_ADDRESS in case permadd is all zeroes.

I already replied to similar suggestion in v4 discussion:

  http://patchwork.ozlabs.org/patch/1060164/#2117512

But I don't have really strong opinion about this. The problem with not
being able to distinguish between "no/unknown permanent address" and
"old kernel not providing the information" is going to become less
important over time.

Michal
