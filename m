Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48209C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1787A206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="sJKlpfmE";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="EGfkJ+0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfLPKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:41:44 -0500
Received: from smtp67.ord1d.emailsrvr.com ([184.106.54.67]:51606 "EHLO
        smtp67.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727404AbfLPKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:41:43 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 05:41:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1576492593;
        bh=AK1LJ3KblE6GDo+Gln+ScoyharN9JqkHG34xHm9NG0c=;
        h=Subject:To:From:Date:From;
        b=sJKlpfmEhT9C9F1RljRyH4Il8+GyJufNI3ScEkxDHRqcb3dOzwQVY7Q/uLFn1Ph2Q
         +dtnoPlzKE/opH0bNh6mWoUIgRdsrOeVFZ7PafZSyAbt1dBqWxaGQTVa5MnHUtUDwA
         SUyZ4E5McBGNamhVzBXPUeM7pj4WaTGgQqt+u3ZI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1576492593;
        bh=AK1LJ3KblE6GDo+Gln+ScoyharN9JqkHG34xHm9NG0c=;
        h=Subject:To:From:Date:From;
        b=EGfkJ+0mGtNEdlLvYR+ZiibBlOSwK4znGDToxgbdGt1oVwSshoqaO5TN4FiE4bYxL
         fMLD4mTw/tSGdvPQzO40pd3EwLwjDtq3tg//enweZN1RE2WSb5bYLoPd0USAmUHPok
         Chj+PEMGTtttfOxf5e4NE+eaq33/KTuQZ5Cbdiyw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1D1B9C00DB;
        Mon, 16 Dec 2019 05:36:32 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 16 Dec 2019 05:36:33 -0500
Subject: Re: [PATCH] staging: comedi: drivers: Fix memory leak in
 gsc_hpdi_auto_attach
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu
References: <20191215013306.18880-1-navid.emamdoost@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <6159c10a-2f5f-e6ef-7a64-4b613e422efa@mev.co.uk>
Date:   Mon, 16 Dec 2019 10:36:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191215013306.18880-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2019 01:33, Navid Emamdoost wrote:
> In the implementation of gsc_hpdi_auto_attach(), the allocated dma
> description is leaks in case of alignment error, or failure of
> gsc_hpdi_setup_dma_descriptors() or comedi_alloc_subdevices(). Release
> devpriv->dma_desc via dma_free_coherent().
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Actually, there is no memory leak (although there is another problem 
that I'll mention below).  If the "auto_attach" handler 
gsc_hpdi_auto_attach() returns an error, then the "detach" handler 
gsc_hpdi_detach() will be called automatically to clean up.  (This is 
true for all comedi drivers).  gsc_hpdi_detach() calls 
gsc_hpdi_free_dma() to free the DMA buffers and DMA descriptors.

> ---
>   drivers/staging/comedi/drivers/gsc_hpdi.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/gsc_hpdi.c b/drivers/staging/comedi/drivers/gsc_hpdi.c
> index 4bdf44d82879..c0c7047a6d1b 100644
> --- a/drivers/staging/comedi/drivers/gsc_hpdi.c
> +++ b/drivers/staging/comedi/drivers/gsc_hpdi.c
> @@ -633,16 +633,17 @@ static int gsc_hpdi_auto_attach(struct comedi_device *dev,
>   	if (devpriv->dma_desc_phys_addr & 0xf) {
>   		dev_warn(dev->class_dev,
>   			 " dma descriptors not quad-word aligned (bug)\n");
> -		return -EIO;
> +		retval = -EIO;
> +		goto release_dma_desc;
>   	}
>   
>   	retval = gsc_hpdi_setup_dma_descriptors(dev, 0x1000);
>   	if (retval < 0)
> -		return retval;
> +		goto release_dma_desc;
>   
>   	retval = comedi_alloc_subdevices(dev, 1);
>   	if (retval)
> -		return retval;
> +		goto release_dma_desc;
>   
>   	/* Digital I/O subdevice */
>   	s = &dev->subdevices[0];
> @@ -660,6 +661,15 @@ static int gsc_hpdi_auto_attach(struct comedi_device *dev,
>   	s->cancel	= gsc_hpdi_cancel;
>   
>   	return gsc_hpdi_init(dev);
> +
> +release_dma_desc:
> +	if (devpriv->dma_desc)
> +		dma_free_coherent(&pcidev->dev,
> +				  sizeof(struct plx_dma_desc) *
> +				NUM_DMA_DESCRIPTORS,
> +				devpriv->dma_desc,
> +				devpriv->dma_desc_phys_addr);
> +	return retval;
>   }
>   
>   static void gsc_hpdi_detach(struct comedi_device *dev)
> 

This patch could actually result in devpriv->dma_desc being freed twice 
- once in the 'release_dma_desc:' code and again when gsc_hpdi_detach() 
is called externally as part of the clean-up.

The real bug in the original code is that it does not check whether any 
of the calls to dma_alloc_coherent() returned NULL.  If any of the calls 
to dma_alloc_coherent() returns NULL, gsc_hpdi_auto_attach() needs to 
return an error (-ENOMEM).  The subsequent call to gsc_hpdi_detach() 
will then free whatever DMA coherent buffers where allocated.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
