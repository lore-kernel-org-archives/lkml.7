Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F4DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784732064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxFQR+ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfH0WXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:23:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34500 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0WXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:23:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so251970pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yf7KPUEZygXXJwexFq8sVNy80of36QU2BvfS1YFc1uQ=;
        b=DxFQR+oulqH7TZnTFeO0AXmXGWRw8zDTd9MWpugL+0n0Aib5ZMDh0gKtEc64fyTaiU
         FOLFQM2CYjumpVL2LFM5EEYzq4YUwR6QM+ekFlz7+xb+HRUbv/RyO2SJnKXHK3b0s/Yd
         IMZgA4l2y+ygNdcJ2lwr9Nf98wFppYDeZP7g7/uvRjzpBhkCXktHh6rJ0Q5sObuQCLxi
         +dOE9bCEq8kSCE3qyIGnytkRwVgV9bV4LTVBmEjwGchqt6zzrZB7w8HYm+k4cH8NwrPa
         Up8sfath9FNbmrmDKJ03kPgTxUQYfR7SHwXZf27HzkMOy7vJNst6hgvquS/xoNnBS0OE
         QEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yf7KPUEZygXXJwexFq8sVNy80of36QU2BvfS1YFc1uQ=;
        b=C2Y/rPPt35uwwRPt7o2BIXQkl/Q3oFrzyCAMgimWf78J9ulUzs6FCT/qd3L2AEk8qJ
         rj+uE2ttVlIQ3B9ChefhV0OfWif8SgHOkqwhiP+hnSdbi9kXMlbJ+Y4Ppg9/nworLxY4
         f1cME4/87cenz+iDtODuCYRGWsOEFeMdz0BAhDT1f22NErjyfN61lWAhgkbjtrBxIHHr
         GPQQIagT30xjeUJt6fRkcMxy738Jxq7TphcgiBIj703zJhv34G8T6E16oevrwqu9sWhZ
         cGiXJkf6vmy3vwvhmnA9EL7RtZ54lFujrdWoEPact7eSW64+z4SMJMjKlXvBHeE2G5/n
         Qwig==
X-Gm-Message-State: APjAAAVTJ7EOucfS3GbWb7nHOgQdkqTGbL6ghNSd1z9phbUVHi+S0yP6
        pgBGwmRNZLl9HZsBFpD10rY4bg==
X-Google-Smtp-Source: APXvYqwT2hpO40tTWBillytawrpLvYzOYf+8qLwBYvEHB+YRDUUxG6ERLaAlK0jg+ytA3DztYQumOA==
X-Received: by 2002:a17:90a:2047:: with SMTP id n65mr1050342pjc.5.1566944586260;
        Tue, 27 Aug 2019 15:23:06 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z25sm313775pfa.91.2019.08.27.15.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:23:05 -0700 (PDT)
Date:   Tue, 27 Aug 2019 15:23:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     linux-remoteproc@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] rpmsg: virtio_rpmsg_bus: replace "%p" with "%pK"
Message-ID: <20190827222303.GL6167@minitux>
References: <20181024011909.21674-1-s-anna@ti.com>
 <40831f80-1e36-66ca-b8e5-684d46ba167e@ti.com>
 <20190827051007.GK1263@builder>
 <8d36d695-dd66-c21f-f49e-f6dc3dbdfc5a@ti.com>
 <20190827220711.GK6167@minitux>
 <619b06b0-c3cc-e36f-c3e5-d13e98520c9c@ti.com>
 <9c5f95a0-c95b-bf68-e78f-6e3d4d837b1e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c5f95a0-c95b-bf68-e78f-6e3d4d837b1e@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Aug 15:17 PDT 2019, Suman Anna wrote:

> On 8/27/19 5:15 PM, Suman Anna wrote:
> > On 8/27/19 5:07 PM, Bjorn Andersson wrote:
> >> On Tue 27 Aug 13:25 PDT 2019, Suman Anna wrote:
> >>
> >>> Hi Bjorn,
> >>>
> >>> On 8/27/19 12:10 AM, Bjorn Andersson wrote:
> >>>> On Fri 09 Aug 13:25 PDT 2019, Suman Anna wrote:
> >>>>
> >>>>> Hi Bjorn,
> >>>>>
> >>>>
> >>>> Hi Suman
> >>>>
> >>>>> On 10/23/18 8:19 PM, Suman Anna wrote:
> >>>>>> The virtio_rpmsg_bus driver uses the "%p" format-specifier for
> >>>>>> printing the vring buffer address. This prints only a hashed
> >>>>>> pointer even for previliged users. Use "%pK" instead so that
> >>>>>> the address can be printed during debug using kptr_restrict
> >>>>>> sysctl.
> >>>>>
> >>>>> Seems to have been lost among the patches, can you pick up this trivial
> >>>>> patch for 5.4? Should apply cleanly on the latest HEAD as well.
> >>>>>
> >>>>
> >>>> I share Andrew's question regarding what benefit you have from knowing
> >>>> this value. Should we not just remove the va from the print? Or do you
> >>>> actually have a use case for it?.
> >>>
> >>> I mainly use it during debug when comparing against kernel_page_tables
> >>> and vmallocinfo. The pools that we use are not always guaranteed to be
> >>> from linear memory, and behavior changes when using with CMA or DMA pools.
> >>>
> >>
> >> Thanks Suman. It seems to me that there's room for improvement to aid
> >> this kind of debugging. But your usecase seems reasonable, so I'm
> >> merging the patch.
> > 
> > Thanks Bjorn.
> 
> Btw, looks like you applied the patch against rproc-next instead of
> rpmsg-next.
> 

Thanks for noticing so quick; I moved the change to the correct
branch.

Regards,
Bjorn

> regards
> Suman
> 
> > 
> >>
> >>> Note that usage of %pK does not leak the addresses automatically, but
> >>> atleast enables me to get the values when needed. The changes also bring
> >>> the usage in rpmsg core in sync with the remoteproc core.
> >>>
> >>
> >> Sounds like shouldn't have merged them in remoteproc then ;P
> > 
> > Slightly different reasoning looking at the commit, it was probably when
> > %p was leaking the addresses.
> > 
> > regards
> > Suman
> > 
> >>
> >> Thanks,
> >> Bjorn
> >>
> >>> regards
> >>> Suman
> >>>
> >>>>
> >>>> Regards,
> >>>> Bjorn
> >>>>
> >>>>> regards
> >>>>> Suman
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
> >>>>>> ---
> >>>>>>  drivers/rpmsg/virtio_rpmsg_bus.c | 2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> >>>>>> index f29dee731026..1345f373a1a0 100644
> >>>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >>>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >>>>>> @@ -950,7 +950,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>>>>  		goto vqs_del;
> >>>>>>  	}
> >>>>>>  
> >>>>>> -	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
> >>>>>> +	dev_dbg(&vdev->dev, "buffers: va %pK, dma %pad\n",
> >>>>>>  		bufs_va, &vrp->bufs_dma);
> >>>>>>  
> >>>>>>  	/* half of the buffers is dedicated for RX */
> >>>>>>
> >>>>>
> >>>
> > 
> 
