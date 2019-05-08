Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A94FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E9C21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557301218;
	bh=qOS5uuv88WJKJrH6XmYq0yHYwZN8cqXopaegcnUaWPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wfMSoRtBKVsTdfrpztyi2s+Jw7rVe18Nhv8roDCEiiWMuiKF+J9MKZKp2DS6dTpIT
	 +CLOtbKBJs6UaBBDniiIN0+wWWb3FOPBnPMutCMdi5zflZA32Sv1d3Di5/0GWqo5op
	 SxTOReeb8DG2pCTgoK81kfC4ouQauHD9wbH55GuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEHHkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfEHHkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:40:16 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3865A20644;
        Wed,  8 May 2019 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557301215;
        bh=qOS5uuv88WJKJrH6XmYq0yHYwZN8cqXopaegcnUaWPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCQdFS9eGR+3GPdpoKN3ZYAS2u8GNUZikZpB38WJf/2sQjlK5wMgMQGSaKwlGDT25
         NUnM7fC1VKQZW75J6CtdZPE6BA6si/7dnU+G+tbu59H4Cd5Jda271/DkBNYDLYof2j
         vfRm9RHDIOv7Mjvr5hVGWuvQDfV6/xa9vXvqzZ1E=
Date:   Wed, 8 May 2019 13:10:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/7] soundwire: add Slave sysfs support
Message-ID: <20190508074009.GU16052@vkoul-mobl>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
 <20190504010030.29233-3-pierre-louis.bossart@linux.intel.com>
 <20190504065444.GC9770@kroah.com>
 <c675ea60-5bfa-2475-8878-c589b8d20b32@linux.intel.com>
 <20190506151953.GA13178@kroah.com>
 <20190506162208.GI3845@vkoul-mobl.Dlink>
 <be72bbb1-b51f-8201-fdff-958836ed94d1@linux.intel.com>
 <20190507051959.GC16052@vkoul-mobl>
 <fde9c4cd-518b-cb67-5b05-1608c9d029e4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde9c4cd-518b-cb67-5b05-1608c9d029e4@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-19, 08:54, Pierre-Louis Bossart wrote:
> On 5/7/19 12:19 AM, Vinod Koul wrote:
> > On 06-05-19, 11:46, Pierre-Louis Bossart wrote:
> > > On 5/6/19 11:22 AM, Vinod Koul wrote:
> > > > On 06-05-19, 17:19, Greg KH wrote:
> > > > > On Mon, May 06, 2019 at 09:42:35AM -0500, Pierre-Louis Bossart wrote:
> > > > > > > > +
> > > > > > > > +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> > > > > > > > +{
> > > > > > > > +	struct sdw_slave_sysfs *sysfs;
> > > > > > > > +	unsigned int src_dpns, sink_dpns, i, j;
> > > > > > > > +	int err;
> > > > > > > > +
> > > > > > > > +	if (slave->sysfs) {
> > > > > > > > +		dev_err(&slave->dev, "SDW Slave sysfs is already initialized\n");
> > > > > > > > +		err = -EIO;
> > > > > > > > +		goto err_ret;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	sysfs = kzalloc(sizeof(*sysfs), GFP_KERNEL);
> > > > > > > 
> > > > > > > Same question as patch 1, why a new device?
> > > > > > 
> > > > > > yes it's the same open. In this case, the slave devices are defined at a
> > > > > > different level so it's also confusing to create a device to represent the
> > > > > > slave properties. The code works but I am not sure the initial directions
> > > > > > are correct.
> > > > > 
> > > > > You can just make a subdir for your attributes by using the attribute
> > > > > group name, if a subdirectory is needed just to keep things a bit more
> > > > > organized.
> > > > 
> > > > The key here is 'a subdir' which is not the case here. We did discuss
> > > > this in the initial patches for SoundWire which had sysfs :)
> > > > 
> > > > The way MIPI disco spec organized properties, we have dp0 and dpN
> > > > properties each of them requires to have a subdir of their own and that
> > > > was the reason why I coded it to be creating a device.
> > > 
> > > Vinod, the question was not for dp0 and dpN, it's fine to have
> > > subdirectories there, but rather why we need separate devices for the master
> > > and slave properties.
> > 
> > Slave does not have a separate device. IIRC the properties for Slave are
> > in /sys/bus/soundwire/device/<slave>/...
> 
> I am not sure this is correct
> 
> ACPI defines the slaves devices under
> /sys/bus/acpi/PRP0001, e.g.

Yes the bus will create 'soundwire slave' device type (In acpi case
created from ACPI walk) and we do link the ACPI as the firmware node.
This is 'not' created for properties but for soundwire representation of
slave devices. This is the one code driver attaches to.
 
> /sys/bus/acpi/devices/PRP00001:00/device:17# ls

Yes this would the companion ACPI device

> adr                                 mipi-sdw-dp-5-sink-subproperties
> intel-endpoint-descriptor-0         mipi-sdw-dp-6-source-subproperties
> intel-endpoint-descriptor-1         mipi-sdw-dp-7-sink-subproperties
> mipi-sdw-dp-0-subproperties         mipi-sdw-dp-8-source-subproperties
> mipi-sdw-dp-1-sink-subproperties    path
> mipi-sdw-dp-1-source-subproperties  physical_node
> mipi-sdw-dp-2-sink-subproperties    power
> mipi-sdw-dp-2-source-subproperties  subsystem
> mipi-sdw-dp-3-sink-subproperties    uevent
> mipi-sdw-dp-4-source-subproperties
> 
> but the sysfs for slaves is shown as
> /sys/bus/acpi/devices/PRP00001:00/int-sdw.0/sdw:0:25d:700:0:0# ls
> bank_delay_support  master_count             sink_ports
> ch_prep_timeout     mipi_revision            source_ports
> clk_stop_mode1      modalias                 src-dp2
> clk_stop_timeout    p15_behave               src-dp4
> dp0                 paging_support           subsystem
> driver              power                    test_mode_capable
> firmware_node       reset_behave             uevent
> hda_reg             simple_clk_stop_capable  wake_capable
> high_PHY_capable    sink-dp1
> index_reg           sink-dp3
> 
> and in sys/bus/soundwire/devices/sdw:0:25d:700:0:0# ls

I think both are same nodes. Since the SoundWire slave is a child of
master it appears under int-sdw.0 as well

> bank_delay_support  master_count             sink_ports
> ch_prep_timeout     mipi_revision            source_ports
> clk_stop_mode1      modalias                 src-dp2
> clk_stop_timeout    p15_behave               src-dp4
> dp0                 paging_support           subsystem
> driver              power                    test_mode_capable
> firmware_node       reset_behave             uevent
> hda_reg             simple_clk_stop_capable  wake_capable
> high_PHY_capable    sink-dp1
> index_reg           sink-dp3
> 
> So I would think we *do* create a new device for each slave instead of using
> the one that's already exposed by ACPI.
> 
> > 
> > For master yes we can skip the device creation, it was done for
> > consistency sake of having these properties ties into sys/bus/soundwire/
> > 
> > I don't mind if they are shown up in respective device node (PCI/platform
> > etc) /sys/bus/foo/device/<>
> > 
> > But for creating subdirectories you would need the new dpX devices.
> 
> yes, that's agreed.

-- 
~Vinod
