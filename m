Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEADC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F49121773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 05:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565329638;
	bh=0NGH7pa4qGdi2942c1QYy0xh8Num+O/K8NEalY+oyGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8dfwV1aghbwyEmaw+UNJb8oCAS+vBmryf5po0r0kTkYQ68xJRXTIKKwpcF2j6ltd
	 gApz+Ci8RHfXH4XLo6z74MhZLYKU4wTGzoptiyV7kaWsdT9kgoc/ZWlpLupxP1cNxP
	 tXeP1AHnKcpuZMh/89lL1L2KMXchiRGYjbG6HR3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405608AbfHIFrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 01:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfHIFrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 01:47:16 -0400
Received: from localhost (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FFCB20C01;
        Fri,  9 Aug 2019 05:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565329635;
        bh=0NGH7pa4qGdi2942c1QYy0xh8Num+O/K8NEalY+oyGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWDkjNU0fHKREEctsjhTGG5vYGpFBmwBGgIRi6C5Qm9oTsvdakjZY6PAceWV6hCy1
         Dd6GSPZoVIF5PFHFtKsno0L0SVfpWY32J5jE1/NbjYqJNVwHm8ADRzfAxlACBrECmt
         GkWzMKQFOFxvkSGeoEyLjcvlrPk01QN5hxtuAAVk=
Date:   Fri, 9 Aug 2019 11:16:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for
 slave devices
Message-ID: <20190809054602.GK12733@vkoul-mobl.Dlink>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
 <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
 <564f5fa4-59ec-b4e5-a7a5-29dee99039b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <564f5fa4-59ec-b4e5-a7a5-29dee99039b3@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-19, 16:17, Srinivas Kandagatla wrote:
> Thanks for taking time to review.
> 
> On 08/08/2019 16:00, Pierre-Louis Bossart wrote:
> > 
> > > @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
> > >       slave->dev.release = sdw_slave_release;
> > >       slave->dev.bus = &sdw_bus_type;
> > > +    slave->dev.of_node = of_node_get(to_of_node(fwnode));
> > 
> > shouldn't this protected by
> > #if IS_ENABLED(CONFIG_OF) ?
> > 
> These macros and functions have dummy entries, so it should not be an issue.
> I did build soundwire with i386_defconfig with no issues.

That means this function was compiled without errors, that is not strange nowadays
given the ARM compiles ACPI and x86 OF, so check with OF being disable
just to be safe :) I think dummy entries are helping

> 
> > >       slave->bus = bus;
> > >       slave->status = SDW_SLAVE_UNATTACHED;
> > >       slave->dev_num = 0;
> > > @@ -112,3 +114,48 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
> > >   }
> > >   #endif
> > > +
> > > +/*
> > > + * sdw_of_find_slaves() - Find Slave devices in master device tree node
> > > + * @bus: SDW bus instance
> > > + *
> > > + * Scans Master DT node for SDW child Slave devices and registers it.
> > > + */
> > > +int sdw_of_find_slaves(struct sdw_bus *bus)
> > > +{
> > > +    struct device *dev = bus->dev;
> > > +    struct device_node *node;
> > > +
> > > +    for_each_child_of_node(bus->dev->of_node, node) {
> > > +        struct sdw_slave_id id;
> > > +        const char *compat = NULL;
> > > +        int unique_id, ret;
> > > +        int ver, mfg_id, part_id, class_id;
> > > +
> > > +        compat = of_get_property(node, "compatible", NULL);
> > > +        if (!compat)
> > > +            continue;
> > > +
> > > +        ret = sscanf(compat, "sdw%x,%x,%x,%x",
> > > +                 &ver, &mfg_id, &part_id, &class_id);
> > > +        if (ret != 4) {
> > > +            dev_err(dev, "Manf ID & Product code not found %s\n",
> > > +                compat);
> > > +            continue;
> > > +        }
> > > +
> > > +        ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
> > > +        if (ret) {
> > > +            dev_err(dev, "Instance id not found:%d\n", ret);
> > > +            continue;
> > 
> > I am confused here.
> > If you have two identical devices on the same link, isn't this property
> > required and that should be a real error instead of a continue?
> 
> Yes, I agree it will be mandatory in such cases.
> 
> Am okay either way, I dont mind changing it to returning EINVAL in all the
> cases.

Do we want to abort? We are in loop scanning for devices so makes sense
if we do not do that and continue to check next one..

-- 
~Vinod
