Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D3AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8532B21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568921894;
	bh=Kdd48kV9rxB8tD0Euh0gJPqWjrtHztGyM+E9VlOArbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=klQ9nUWvRoxgs0InCmh9o2QYD6O61BEYk9S1x+LX272xatT3GF8uuzkBXFuJhvPrA
	 f4LijbIcrOaSqzalwpJwc547ppyHFOCT56PW3lncVsNy7L/WUmBvXmKP34VRBLO4/x
	 OWTWraMwKkeoVX8FrALnHFMyrbIGj0hp2AsT0UdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392383AbfISTiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392354AbfISTiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:38:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC3721907;
        Thu, 19 Sep 2019 19:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568921892;
        bh=Kdd48kV9rxB8tD0Euh0gJPqWjrtHztGyM+E9VlOArbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ysIhimgFRoRKPndsu8xugv24mx5P35MkKujSQD7hmVfmeQx+hnc70Ak+sdrzEzcjI
         K1K0PrNtglFg7Gy6bkXW6ITb5a21l5JCMNawHolZLrFucMZbIdNW5V9eO85Tn+f4OK
         2NjmmFCn9ccMNBLgC5O3gGeTZ0u+QXPG+TW5Jheo=
Date:   Thu, 19 Sep 2019 12:38:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: threads-max observe limits
Message-Id: <20190919123812.8601e63d31cf44178dcbe75e@linux-foundation.org>
In-Reply-To: <20190919075911.GA15782@dhcp22.suse.cz>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
        <87ftku96md.fsf@x220.int.ebiederm.org>
        <20190918071541.GB12770@dhcp22.suse.cz>
        <20190919075911.GA15782@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 09:59:11 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 18-09-19 09:15:41, Michal Hocko wrote:
> > On Tue 17-09-19 12:26:18, Eric W. Biederman wrote:
> [...]
> > > b) Not being able to bump threads_max to the physical limit of
> > >    the machine is very clearly a regression.
> > 
> > ... exactly this part. The changelog of the respective patch doesn't
> > really exaplain why it is needed except of "it sounds like a good idea
> > to be consistent".
> 
> Any take on this Heinrich? If there really is not strong reasoning about
> the restricting user input then I will suggest reverting 16db3d3f1170
> ("kernel/sysctl.c: threads-max observe limits")

I agree, based on what I'm seeing in this thread.
