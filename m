Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00FFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7E62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="a+beFt5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfJWRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:11:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36122 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJWRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:11:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so11297032wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8iXr1bCPucfV/BlXP7h0HwuQ+aEH9N73PCJr0os4hb4=;
        b=a+beFt5hlK6LWDd39o4iUH2O4kIKkoGy0GQejP4br9DTQGzzZaqNpbXf7JfWhMz4QJ
         9PgtlErWslt/jNEYZodCeT7c7mw+agWZZiD/GIOCOcEYcpNiXsqnV/DLbLkL84Kn+z+q
         9l/GjwurRB2XpmkM3AxWiecfKk8ZQ7+Wc8pOo5wqxGnMKf5bO3m1Bi7F/mKRbsfCe8qg
         J1ezNYNAlrUBlf6o/3YAWOAiGxeEvXT7SB6XmVU2fdchrO0UngUrn8HufSttMAm0/JZc
         4qM3WFu00rI35leLynnYDAeJ0zY54CGeuEnbRqWOd8CPigj08oQVUJg8KvZNj7cIFfR+
         Tn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8iXr1bCPucfV/BlXP7h0HwuQ+aEH9N73PCJr0os4hb4=;
        b=EsUHmgYiX9Jd/8q55SrNyuqk2Q6r9bAe4khBLiQNX8bMHWLQMEieRnQWAOJJuGVfLr
         MnNISCjbxgQiNHobzepjF1s+XE1RpkHjzig5tQ8mQXNfMEwHIjJLOcNZYwRsEKt8tmwu
         AMoS3Riq/Ln3jKT73ppT9/a76QMR3sJXokBqUGdJmxpurdKVa5oqIGTVAFrqnt2EOIAZ
         yzRwYiX1Li54gejq/FgDCfscmuRG5wnqAUexpqXFedzleGm2xTcoXY4G9YgZC2vIcTM4
         4WZo1OatIBiRqeyG7ozvZ8k1/JNByDLnbR+w9ylYW8VEefL6dpTczCJ8bTEDxvre0tFw
         uQKQ==
X-Gm-Message-State: APjAAAXbpv1uNiB3pOMjFlZkswcbfD8Jb/OmZMktvXPDRLy9v5zMF07t
        uMdH3IhBBW05F9x+Hcv5kLT4Lg==
X-Google-Smtp-Source: APXvYqwpTE3GTWCdJrVBwx/BqQXBWybfQma1tOKgevAQzX9IySqj6rGT20KkOOOHSfYwnkJSswVfjA==
X-Received: by 2002:a7b:c395:: with SMTP id s21mr946644wmj.114.1571850680225;
        Wed, 23 Oct 2019 10:11:20 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id a2sm9365644wrv.39.2019.10.23.10.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:11:19 -0700 (PDT)
Date:   Wed, 23 Oct 2019 19:11:16 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, tiwei.bie@intel.com, jason.zeng@intel.com,
        zhiyuan.lv@intel.com
Subject: Re: [RFC 1/2] vhost: IFC VF hardware operation layer
Message-ID: <20191023171115.GA28355@netronome.com>
References: <20191016011041.3441-1-lingshan.zhu@intel.com>
 <20191016011041.3441-2-lingshan.zhu@intel.com>
 <20191016095347.5sb43knc7eq44ivo@netronome.com>
 <075be045-3a02-e7d8-672f-4a207c410ee8@intel.com>
 <20191021163139.GC4486@netronome.com>
 <15d94e61-9b3d-7854-b65e-6fea6db75450@redhat.com>
 <20191023101329.GE8732@netronome.com>
 <83356b5f-e2f4-ab79-79d7-20d4850c26a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83356b5f-e2f4-ab79-79d7-20d4850c26a9@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:36:13PM +0800, Jason Wang wrote:
> 
> On 2019/10/23 下午6:13, Simon Horman wrote:
> > On Tue, Oct 22, 2019 at 09:32:36AM +0800, Jason Wang wrote:
> > > On 2019/10/22 上午12:31, Simon Horman wrote:
> > > > On Mon, Oct 21, 2019 at 05:55:33PM +0800, Zhu, Lingshan wrote:
> > > > > On 10/16/2019 5:53 PM, Simon Horman wrote:
> > > > > > Hi Zhu,
> > > > > > 
> > > > > > thanks for your patch.
> > > > > > 
> > > > > > On Wed, Oct 16, 2019 at 09:10:40AM +0800, Zhu Lingshan wrote:
> > > > ...
> > > > 
> > > > > > > +static void ifcvf_read_dev_config(struct ifcvf_hw *hw, u64 offset,
> > > > > > > +		       void *dst, int length)
> > > > > > > +{
> > > > > > > +	int i;
> > > > > > > +	u8 *p;
> > > > > > > +	u8 old_gen, new_gen;
> > > > > > > +
> > > > > > > +	do {
> > > > > > > +		old_gen = ioread8(&hw->common_cfg->config_generation);
> > > > > > > +
> > > > > > > +		p = dst;
> > > > > > > +		for (i = 0; i < length; i++)
> > > > > > > +			*p++ = ioread8((u8 *)hw->dev_cfg + offset + i);
> > > > > > > +
> > > > > > > +		new_gen = ioread8(&hw->common_cfg->config_generation);
> > > > > > > +	} while (old_gen != new_gen);
> > > > > > Would it be wise to limit the number of iterations of the loop above?
> > > > > Thanks but I don't quite get it. This is used to make sure the function
> > > > > would get the latest config.
> > > > I am worried about the possibility that it will loop forever.
> > > > Could that happen?
> > > > 
> > > > ...
> > > My understanding is that the function here is similar to virtio config
> > > generation [1]. So this can only happen for a buggy hardware.
> > Ok, so this circles back to my original question.
> > Should we put a bound on the number of times the loop runs
> > or should we accept that the kernel locks up if the HW is buggy?
> > 
> 
> I'm not sure, and similar logic has been used by virtio-pci drivers for
> years. Consider this logic is pretty simple and it should not be the only
> place that virito hardware can lock kernel, we can keep it as is.

Ok, I accept that there isn't much use fixing this if its idomatic and
there are other places virtio hardware can lock up the kernel.

> Actually, there's no need for hardware to implement generation logic, it
> could be emulated by software or even ignored. In new version of
> virtio-mdev, get_generation() is optional, when it was not implemented, 0 is
> simply returned by virtio-mdev transport.
> 
> Thanks
> 
