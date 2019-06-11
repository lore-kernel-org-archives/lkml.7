Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F8C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2667820657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbfFKIx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:53:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:36451 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403836AbfFKIx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:53:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 01:53:58 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Jun 2019 01:53:53 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 Jun 2019 11:53:52 +0300
Date:   Tue, 11 Jun 2019 11:53:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH v7 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Message-ID: <20190611085352.GA27627@kuha.fi.intel.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-6-git-send-email-pawell@cadence.com>
 <20190607101602.GD10298@kuha.fi.intel.com>
 <BYAPR07MB4709F32FF0C6DAE8905703C7DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709F32FF0C6DAE8905703C7DD130@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On Mon, Jun 10, 2019 at 06:33:29AM +0000, Pawel Laszczak wrote:
> >> +static ssize_t cdns3_mode_write(struct file *file,
> >> +				const char __user *ubuf,
> >> +				size_t count, loff_t *ppos)
> >> +{
> >> +	struct seq_file	 *s = file->private_data;
> >> +	struct cdns3 *cdns = s->private;
> >> +	u32 mode = USB_DR_MODE_UNKNOWN;
> >> +	char buf[32];
> >> +	int ret = 0;
> >
> >        int ret;
> >
> >> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> >> +		return -EFAULT;
> >
> >                return -EINVAL;
> 
> Why? I've checked in some place in kernel and after copy_from_user are used EFAULT.
> I think that EINVAL is better but I wanted be  consistent with the rest of kernel. 
> 
> Is there any explanation for this ?

No. You are correct. EFAULT seems to be used with copy_from_user().

thanks,

-- 
heikki
