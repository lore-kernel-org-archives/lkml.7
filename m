Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE6622DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567597329;
	bh=Iu1vh+UB2UTe/P8T2CkcUAMYlHAR9Uq0TtPWxda2pqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nu66k7ixbl1FfpB7hk7e83H/Q6sonBUFnLGUXvT3taPDyqEkKnxjiY4GPgv0DJTTt
	 UmnbTsEgwf0Z0FTPLF9wup3rQA9octl7RVXASEYDaDRoljld58CkuMk07zRRRD+k5L
	 S6xMv1mh8feeInfqhENmNdCf+Sa3qBigftg9P6oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfIDLmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIDLmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:42:08 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC4720820;
        Wed,  4 Sep 2019 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597327;
        bh=Iu1vh+UB2UTe/P8T2CkcUAMYlHAR9Uq0TtPWxda2pqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpDusYLy+uvhV4rv0L+uXxG5hVwlSOCOoihvmRGmo0YMM1lesw1xfGTKuATz1aHee
         djikE5xbk2y8Bf3BabxlRiGlQiDggItPbT/vIESI9SdfrO75il7LkEghSDKZXeyjAp
         a2shKS1pDwU9wwXgaVpNNI/aogkbvbXt7hP3FipE=
Date:   Wed, 4 Sep 2019 17:10:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, alsa-devel@alsa-project.org,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Message-ID: <20190904114059.GU2672@vkoul-mobl>
References: <20190830185212.25144-1-msuchanek@suse.de>
 <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
 <20190904093052.GQ2672@vkoul-mobl>
 <20190904124803.1700a65a@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904124803.1700a65a@naga>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 12:48, Michal Suchánek wrote:
> On Wed, 4 Sep 2019 15:00:52 +0530
> Vinod Koul <vkoul@kernel.org> wrote:
> 
> > On 30-08-19, 11:56, Randy Dunlap wrote:
> > > On 8/30/19 11:52 AM, Michal Suchanek wrote:  
> > > > Fixes the following warning on !ACPI systems:
> > > > 
> > > > drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> > > > not used [-Wunused-function]
> > > >  static int sdw_slave_add(struct sdw_bus *bus,
> > > >             ^~~~~~~~~~~~~
> > > > 
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>  
> > > 
> > > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > > 
> > > I was about to send the same patch.  
> > 
> > So I have applied Srini's patches which add DT support and they use
> > sdw_slave_add(). So next tomorrow should not see this error as it is now
> > used by DT parts as well.
> > 
> > So dropping this patch
> > 
> 
> That should fix the issue for me. I wonder if !ACPI !DT platforms are
> still a thing.

Heh that should trigger this if we have one :D so should a lot more
which depend on some firmware!

-- 
~Vinod
