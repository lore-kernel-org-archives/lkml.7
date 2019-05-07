Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2873C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F6205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEGNRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:17:33 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:52882 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbfEGNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:17:33 -0400
Received: from [46.226.52.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id AB/1F-23123-96581DC5; Tue, 07 May 2019 13:17:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsUyo1hfUjez9WK
  MwfpFahZvHv9jtzjW9oTdYv6Rc6wWzYvXs1lc3jWHzWLRslZmi6XXLzJZtO49wm6xasEBdosr
  T6cyOnB5rJm3htFj56y77B6bVnWyeeyfu4bdY8v+z4wenzfJeez9/JslgD2KNTMvKb8igTXj5
  /0Z7AU7BCreH+pga2DcwtvFyMkhJLCGUeLLXXsQm1fAVGLfj81MILawQITE1gvfgWwODjYBXY
  muO6ZdjFwcIgLfGCWmHVvFDuIwC7xllPj2qIcRpIFFQEWi7dkdNhCbUyBW4v+fwywgRUIC95k
  kZlyfCVbELKAp0br9NzuILSGgIbHh5jEmiM2CEidnPmGBqJGXaN46mxlks5CArMTRS7EQ5QoS
  Z7dMZISwkyTO9V1hm8AoMAvJ1FlIJs1CMmkBI/MqRoukosz0jJLcxMwcXUMDA11DQyNdQ0tjX
  SNjE73EKt1EvdRS3fLU4hJdQ73E8mK94src5JwUvbzUkk2MwJhKKTj4agfjrhXphxglOZiURH
  lF7C/GCPEl5adUZiQWZ8QXleakFh9ilOHgUJLg7W0GygkWpaanVqRl5gCjGyYtwcGjJMKbDpL
  mLS5IzC3OTIdInWLU5Vhw89c8ZiGWvPy8VClx3p0gRQIgRRmleXAjYInmEqOslDAvIwMDgxBP
  QWpRbmYJqvwrRnEORiVh3n6QKTyZeSVwm14BHcEEdMS8jnMgR5QkIqSkGhirPZNmcegmWswQj
  ty3Jn/i6uiTTR/aWq/E75t2xuVH1ZWGDQZKCl9nGClP8lBZ0ce2TJn9x4qtjtuf740QSefiVP
  8YN5VdjFE0unX6KaV55zrnnFo4b2+mMjtnuHR51vxNmf+sgm++/ppvZWKv+2p68xfzSPP/c7Z
  ULpvQarZwNoPzv9ieIDYlluKMREMt5qLiRAABRNN8LwMAAA==
X-Env-Sender: cst@phaseone.com
X-Msg-Ref: server-8.tower-265.messagelabs.com!1557235049!8196729!1
X-Originating-IP: [152.115.47.25]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19072 invoked from network); 7 May 2019 13:17:29 -0000
Received: from unknown (HELO Exchange2.phaseone.com) (152.115.47.25)
  by server-8.tower-265.messagelabs.com with AES256-SHA encrypted SMTP; 7 May 2019 13:17:29 -0000
Received: from cstu16.phaseone.com (172.16.2.207) by Exchange2.phaseone.com
 (172.16.1.180) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 7 May
 2019 15:17:28 +0200
Message-ID: <1557235048.114189.22.camel@phaseone.com>
Subject: Re: [PATCH 3/3] usb: dwc3: gadget: Add support for disabling U1 and
 U2 entries
From:   "Claus H. Stovgaard" <cst@phaseone.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Date:   Tue, 7 May 2019 15:17:28 +0200
In-Reply-To: <BYAPR02MB55918A76A1567C3209860748A7310@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1556792423-4833-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <1556792423-4833-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
         <30102591E157244384E984126FC3CB4F639E7BA8@us01wembx1.internal.synopsys.com>
         <1557176302.18203.20.camel@phaseone.com>
         <BYAPR02MB55918A76A1567C3209860748A7310@BYAPR02MB5591.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.2.207]
X-ClientProxiedBy: Exchange3.phaseone.com (172.16.1.184) To
 Exchange2.phaseone.com (172.16.1.180)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anurag

> > > Please use "-" rather than "_" in the property names.
> > I have thought about this feature over the weekend, and think the
> > naming should be
> > changed to something like "snps,bos-u1-exit-lat-in-us"
> > and named the same in the code. And then be the value used by the
> > get_config_params. E.g. the device-tree is used to set the values
> > directly used for
> > bUxdevExitLat instead of named something not related to exit
> > latency.
> > 
> > With this the name and function is a 1 to 1 match, and you can
> > among others set it to
> > 0 for optaining what Anurag wants.
> > 
> Your suggestion looks good but the problem is the U1 and U2 exit
> latencies are
> fixed values in dwc3 controller(can be found in HCSPARAMS3). Adding
> different
> exit latencies may modify the U1SEL/U2SEL values sent from the host
> but the real
> dwc3 controller exit latencies are not getting changed. Because of
> this reason I
> had opted "snps,dis_u1_entry_quirk", so that the U1/U2 exit latency
> values
> reported in BOS descriptor can be either be zero (when U1/U2 entries
> needs to be
> disabled) or non-zero value (reported in HCSPARAMS3) when U1/U2
> states allowed.
> Based on this I think it is better if we can continue with "snps,dis-
> u1-entry-quirk"
> instead of the "snps,bos-u1-exit-lat-in-us". Please  provide your
> opinion on this.

With this in mind I can see why having direct control over the exit
latency value might not be optimum in many situations.
Regarding the name, I think the snps,dis_u1_entry_quirk will be a good
name, if it is combined with the DCTL control. E.g. remove the configfs
part of my patch, and merge the DCTL control with your patches.
If the dt-binding still only control the bos descriptor I think a
better name is something with u1_force_exist_lat_0 or similar.

I don't think setting bos to 0 or controlling DCTL will be used
individual, so to keep things simple I will vote for
snps,dis_u1_entry_quirk, and then just control all elements regarding
disabling U1/U2 from this dt-binding.

Please cut what your need from my patch.

BR Claus
