Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22F2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfC2Tv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:51:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:20403 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729983AbfC2Tv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:51:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 12:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,285,1549958400"; 
   d="scan'208";a="131361778"
Received: from lparisol-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.46.120])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2019 12:51:25 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 7336621E50; Fri, 29 Mar 2019 21:51:21 +0200 (EET)
Date:   Fri, 29 Mar 2019 21:51:21 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: ov6650: Move v4l2_clk_get() to
 ov6650_video_probe() helper
Message-ID: <20190329195120.zc7u3aju4e355tzm@kekkonen.localdomain>
References: <20190325003501.14687-1-jmkrzyszt@gmail.com>
 <20190325003501.14687-2-jmkrzyszt@gmail.com>
 <20190329183923.t7sxzqf5qa4z3yfs@kekkonen.localdomain>
 <43180252.PEphI5Jep4@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43180252.PEphI5Jep4@z50>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 08:48:19PM +0100, Janusz Krzysztofik wrote:
> Hi Sakari,
> 
> On Friday, March 29, 2019 7:39:24 PM CET Sakari Ailus wrote:
> > Hi Janus,
> > 
> > Thanks for the patchset.
> > 
> > On Mon, Mar 25, 2019 at 01:35:00AM +0100, Janusz Krzysztofik wrote:
> > > ...
> > >  
> > >  done:
> > >  	ov6650_s_power(&priv->subdev, 0);
> > > +	if (ret) {
> > > +eclkput:
> > > +		v4l2_clk_put(priv->clk);
> > 
> > Could you rework the error handling, please? Labels should be outside
> > conditionals. 
> 
> OK.
> 
> > See e.g. the smiapp driver
> > (drivers/media/i2c/smiapp/smiapp-core.c). I've pushed my master branch
> > here:
> > 
> > <URL:https://git.linuxtv.org/sailus/media_tree.git/log/>
> 
> I'm currently syncing my linux-media remote tracking branches with 
> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git
> Should I switch to a different repository, e.g. yours?

Usually Mauro's tree is the best choice. I sometimes forget to update mine.
In this case just make sure these patches apply on top of the one merged
previouly if there's a dependency.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
