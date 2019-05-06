Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC380C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBFA20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557160698;
	bh=AekdLqHpDoOsRjyE4YTt8yYR+74f0A2mIBOAgYZpno4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mnwDx28ywiWojIQvzWiLTVAvkAwH1/V42y3RmWas3lfqJW9dlTMsOxGD5QI2s5/MI
	 Btbi9Sa/Z2Vr9N4HIuKIxspNNbuwcEESBSwBoqSBwlQ+qoPZ/s8JCxPFmvDGDOJGx6
	 +Lb01PUQ96vmXqw9qPdAmPG1TFmCTHWA80pgxU68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEFQiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEFQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:38:17 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D51020578;
        Mon,  6 May 2019 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557160696;
        bh=AekdLqHpDoOsRjyE4YTt8yYR+74f0A2mIBOAgYZpno4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBrU4rBuE3MPa6I6muGRenYoUcTpyx1Mnkwhrx8nhlI1RKIxFNJ7QoCL+fknzhuce
         s0VhHL2Aa/yPpH6tQ1fpnqUzgC9JYH48qUgurR0SAdXulLgD9fN0BIm0mvOY4YBbAk
         IkE5vzwINvW4lZCzvQ3Ea1x3PeXvASZ5IcxGE48I=
Date:   Mon, 6 May 2019 22:08:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 5/7] soundwire: add debugfs support
Message-ID: <20190506163810.GK3845@vkoul-mobl.Dlink>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-6-pierre-louis.bossart@linux.intel.com>
 <20190504070301.GD9770@kroah.com>
 <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e1c3d2-fe29-1683-9253-b66034c62010@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-05-19, 09:48, Pierre-Louis Bossart wrote:

> > > +struct dentry *sdw_bus_debugfs_get_root(struct sdw_bus_debugfs *d)
> > > +{
> > > +	if (d)
> > > +		return d->fs;
> > > +	return NULL;
> > > +}
> > > +EXPORT_SYMBOL(sdw_bus_debugfs_get_root);
> > 
> > _GPL()?
> 
> Oops, that's a big miss. will fix, thanks for spotting this.

Not really. The Soundwire code is dual licensed. Many of the soundwire
symbols are indeed exported as EXPORT_SYMBOL. But I agree this one is
'linux' specific so can be made _GPL.

Pierre, does Intel still care about this being dual licensed or not?

> 
> > 
> > But why is this exported at all?  No one calls this function.
> 
> I will have to check.

It is used by codec driver which are not upstream yet. So my suggestion
would be NOT to export this and only do so when we have users for it
That would be true for other APIs exported out as well.

> > 
> > > +struct sdw_slave_debugfs {
> > > +	struct sdw_slave *slave;
> > 
> > Same question as above, why do you need this pointer?
> 
> will check.

The deubugfs code does hold a ref to slave object to read the data and
dump, this particular instance might be able to get rid of (should be
doable)

> > And meta-comment, if you _EVER_ save off a pointer to a reference
> > counted object (like this and the above one), you HAVE to grab a
> > reference to it, otherwise it can go away at any point in time as that
> > is the point of reference counted objects.
> > 
> > So even if you do need/want this, you have to properly handle the
> > reference count by incrementing/decrementing it as needed.

Yes, but then device exit routine is supposed to do debugfs cleanup as
well, so that would ensure these references are dropped at that point of
time. Greg should that not take care of it or we *should* always do
refcounting.

Thanks
-- 
~Vinod
