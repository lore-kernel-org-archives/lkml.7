Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91329C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8F2217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfDJQtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:49:13 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40870 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfDJQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:49:12 -0400
Received: by mail-wm1-f52.google.com with SMTP id z24so3364141wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZqJ2XOy0jvr3ReTVuFpnaLPmsR/kkyC4sDPBsqIbCic=;
        b=n+eHdXBThpYXeEs5Ycon+3NZRSKQ6ZH9/lTxSyrHS1qtNuxgcCfk2vWjiNYdoc+Vvu
         Ut7JjFSmhUua97xkDg+9xztns36cBlh7a4HqOH2ZJ0U4/raFCUvf7nRoeXW47EZ0q3nj
         sZbm1uk6f+nqJfjhj34Dto44YT8ZiXUCo50AF7Ve+wFtOoZPxjUxIXfKYejuKu/aqstn
         FdEyN8W1WokneOzD57hlFS40UEx2NOr7/p8J68bOGuEzRTt7KIlWx7bydMachO/dr/uM
         IzwrHhBxvPtU9dL3U4PypFPJlwMkFFrLea45WVD6OcGWRJw5vcM3+KQ5kNX95xrz14ol
         n7iA==
X-Gm-Message-State: APjAAAUekrW5Wj2xbFEH9Tzj/7tAREvyBw7ZvU8/IArGgyqDzgBhyEVK
        5LKHNuKcu7GvEoeMe+GCQc4ipbCj1sQ=
X-Google-Smtp-Source: APXvYqyTvHAtwTZwVMP2XN3c5ro+XRKuBXOAfXiGtp4KaZTczFWuCbriBSMfxkAqu+FookKxNBZlXQ==
X-Received: by 2002:a7b:cb16:: with SMTP id u22mr3521008wmj.60.1554914950607;
        Wed, 10 Apr 2019 09:49:10 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z14sm55458713wrv.78.2019.04.10.09.49.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:49:09 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: collision avoidance
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Kyle Tso <kyletso@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190322121745.159768-1-kyletso@google.com>
 <20190404141345.GF21319@kuha.fi.intel.com>
 <08a6d422-e8f7-303e-7bf1-952344f2c182@roeck-us.net>
 <CAGZ6i=2zKLhS4By8Xanc863G+jSxPYg8SLU-UHkY94r5MiEYag@mail.gmail.com>
 <20190409130230.GC20058@kuha.fi.intel.com>
 <20190409130649.GD20058@kuha.fi.intel.com>
 <9c9d17e3-bd99-c877-359c-a0a1b10a8d73@redhat.com>
 <AM5PR1001MB099440C3AA6DA6BA2AB0F2AE802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CAGZ6i=0rRgNH5bU-zcP58MNi+VSa+xeAQWL67egaZ-ui-ebmYA@mail.gmail.com>
 <9f9a2de9-2cfb-385c-8e99-54b2587113ce@redhat.com>
 <AM5PR1001MB09943830CFED9CB321CC883D802E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <76a3c6df-63c0-78e7-c1ca-c83a30e95d38@redhat.com>
Message-ID: <7dd7ce29-b4e5-02c1-6bdc-11d0e1f77a5f@redhat.com>
Date:   Wed, 10 Apr 2019 18:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <76a3c6df-63c0-78e7-c1ca-c83a30e95d38@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If I understand the datasheet correctly:
> 
> "The FUSB302 has the capability to do autonomous
> DRP toggle. In autonomous toggle the FUSB302
> internally controls the PDWN1, PDWN2, PU_EN1 and
> PU_EN2, MEAS_CC1 and MEAS_CC2 and implements
> a fixed DRP toggle between presenting as a SRC and
> presenting as a SNK. Alternately, it can present as a
> SRC or SNK only and poll CC1 and CC2 continuously."
> 
> It is still attaching Rp resp Rd to CC1 or CC2 one at a time
> to detect polarity, so it is still toggling, it just is not
> doing dual-role toggling. This is also expected behavior for
> a sink, a sink may not present Rd on both CC pins at the
> same time, otherwise the source cannot detect the polarity
> and the source also cannot detect if Vconn is necessary.

Erm the "a sink may not present Rd on both CC pins at the same time"
bit obviously is wrong, ignore that please.
