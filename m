Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E6FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06ED22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566999574;
	bh=6293ZGylEn4OxyQXkqlfv9nHz0br1szMeuGh6Fg1x9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gp4UDp5g7o3647+tyRu8qmQAtYre07ZEuN1qBDw0QYX2+l0038aXiw6uaQkTbbQLF
	 01wBGWFb3EjeNTIJiHatFSaYUT33VY0nqIE4YXLj+rqiwXCrHtUIQdiegt2p/mSvMC
	 RaZ4GCkzXz+8yGURjWcLPLrsWe5vbnVHDIz611Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfH1Njd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:39:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33374 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfH1Nja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:39:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id g9so2233358lfb.0;
        Wed, 28 Aug 2019 06:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XfvqJu9BApSnnB/3JXrqLAVXQ9aClPdswJgKx9f9+qc=;
        b=doWxQoC+Ah3/3AH88K2YsY1NXHVx46jPwrn4eg0raNlXUqPUc+UYBUJqJYASMvWEGN
         aE5KDjTU6QgQ5q+eRrn1iaT8u9J20tsoXwMf0SCKUfxiHok7tsUVUFX9vrPdSph3a/bP
         f3gRjOcoCyWe2/BtyTddqFtkJIL/kk04vLOsDlYsRdLiBUgDOQ1weQjXuk9ZasPz5ONb
         pkmD1IVN2s1EvJE7NyYrFxwxtko3hpWtJRAWG9Hl6N7OkAlJXFBzaDHd5mxlFqtadJyH
         vQEDO8tjcECJXqG2/4WjNwV90c3mREhgJaspKDabZJdnaEUvRKAP80+NVzg1VrSAe9PC
         qRsQ==
X-Gm-Message-State: APjAAAWd/IJ8vjYx5Gkmi61bOXX+AUujiybzz2tBxyRxq8VKuRXx3I31
        BnY6aCF5A5BTy513iYnx/fY=
X-Google-Smtp-Source: APXvYqw86Voga75zop8qCSWYkYmKp6nuBxBwzyI1JZeW/NknsO6JDRlTk3L8uHcKZvkXk8vSSE5tkg==
X-Received: by 2002:a05:6512:28d:: with SMTP id j13mr2675773lfp.12.1566999568728;
        Wed, 28 Aug 2019 06:39:28 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id r20sm846817lfm.41.2019.08.28.06.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 06:39:27 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i2yAW-0007rt-9w; Wed, 28 Aug 2019 15:39:24 +0200
Date:   Wed, 28 Aug 2019 15:39:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthew Michilot <matthew.michilot@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: ftdi_sio: add support for FT232H CBUS
 gpios
Message-ID: <20190828133924.GG13017@localhost>
References: <20190808222348.4428-1-matthew.michilot@gmail.com>
 <20190815174054.20240-1-matthew.michilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815174054.20240-1-matthew.michilot@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 05:40:54PM +0000, Matthew Michilot wrote:
> Enable support for cbus gpios on FT232H. The cbus configuration is
> stored in one word in the EEPROM at byte-offset 0x1a with the mux

You forgot to fix the copy-paste error here; it should be "two words" as
I mentioned before.

> config for ACBUS5, ACBUS6, ACBUS8 and ACBUS9 (only pins that can be
> configured as I/O mode).
> 
> Tested using FT232H by configuring one ACBUS pin at a time.
> 
> Signed-off-by: Matthew Michilot <matthew.michilot@gmail.com>
> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> ---
> V2:
> - made hex notation all lowercase for consistency
> - allocated 4 bytes instead of 2 bytes for buffer
> - improved documentation on FT232H CBUS memory mapping
> - fixed CBUS pins being incorrectly mapped to the wrong gpios
> - sorted case labels alphabetically

Now applied after amending the commit message.

Thanks,
Johan
