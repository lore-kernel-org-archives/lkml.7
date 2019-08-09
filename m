Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD92C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3904721773
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 04:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565326581;
	bh=A5FsRFBnniHu6TuyUAvzx8w6I2VU88+WwPu49KfYdyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FKxJxZx5NRc0K78WNA3ZUtnyl0vCewdQpJNqb3yD1EwBHS7RNKKlu6uBHSkViFo5D
	 ta3GX2EltGvutkXafBroqbFJ8yRd8gTGv2L7K5CT9NGLImMfk9P4hMfe3LCEzO/6cO
	 PwcyTNZayVaLGHi3IiylwkAYBkhTmO+eh/Akf2fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbfHIE4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 00:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfHIE4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 00:56:19 -0400
Received: from localhost (unknown [122.167.65.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA381214C6;
        Fri,  9 Aug 2019 04:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565326578;
        bh=A5FsRFBnniHu6TuyUAvzx8w6I2VU88+WwPu49KfYdyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoyQqSnrmea2hOYn2w61l5JiMl9KSvEEq17SQ7eUiUSozzNoesRysI70yB9i0wxF+
         9wRKIgAg8dLsTip+mjdBpVF1FFWzXQmB+GJFOau4cnpfQB7XZD6jjJjP+wi4WDT38E
         4o3Z2r72B8+PL50K6DR2DQvsoyHLdXA+EvVeWxG4=
Date:   Fri, 9 Aug 2019 10:24:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190809045459.GG12733@vkoul-mobl.Dlink>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
 <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
 <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
 <20190808195216.GM3795@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808195216.GM3795@sirena.co.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-08-19, 20:52, Mark Brown wrote:
> On Thu, Aug 08, 2019 at 05:48:56PM +0100, Srinivas Kandagatla wrote:
> > On 08/08/2019 16:58, Pierre-Louis Bossart wrote:
> 
> > > > +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> > > > +          Enumeration Address. Instance ID is for the cases
> > > > +          where multiple Devices of the same type or Class
> > > > +          are attached to the bus.
> 
> > > so it is actually required if you have a single Slave device? Or is it
> > > only required when you have more than 1 device of the same type?
> 
> > This is mandatory for any slave device!
> 
> If it's mandatory the wording is a bit unclear.  How about something
> like:
> 
> 	Should be ('Instance ID') from the SoundWire Enumeration
> 	Address.  This must always be provided, if multiple devices
> 	with the same type or class or attached to the bus each
> 	instance must have a distinct value.

That helps to make it clear.

Also the section of properties starts with Mandatory property, it should
be made Mandatory Properties instead, like in other binding docs to make
it clear that properties mentioned in the section are mandatory

-- 
~Vinod
