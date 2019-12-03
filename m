Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE598C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6D1205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575391207;
	bh=yDHTVydKpHo2PrvhBJGjjNsmGzjZA85DLCYv38qIEQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e8jSqzRimsaDTVYu2fxHXpfuFXvVec3dN1LIraMHV+KZxYnEQlR7s7LPwa2KybneR
	 5RW4iX2sPxh0RlEwZt4NvRjt8K6NULjbv6CL8cCYhMDXDgPOflG3LCUcVYGqBc1twS
	 p+xiKM/uY5C5EeFrln7FkVCT754DTGGy3LX/055s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfLCQkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:40:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44976 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:40:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so3490873lfa.11;
        Tue, 03 Dec 2019 08:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZBSf17SGx1+gGK9WEkvD1hP9LHGvHUx0+b+fQE1FCQ=;
        b=potk/3GxkmVkK1+c6BgADK2LIkUF/uZGUpTHRnkaZxDdGE3oOSEISUSBE+50Z6RWQI
         hvHeTGOsJt7W6uvhRdl3FcaAsv2iB6kTwntN3i8B+F0yl0aSpV99FJ7ePAQi0fXgCIkE
         eCyVIfW7VesSgMUAl3DX0MffjMObOP3qJbiPHXlyqr/nzAP0j7R4yHNbldGiHIMtH1i4
         ihSXM2YHA4iWB8f/NE7iYs+RORPDDNK9ZOmT7oqwHFOvnOnlBB15Tnq1W1s/cLjhdMEf
         piAeFOsVV3tZKTJ+gNEoDw0bKBfv6PQAmjtmFZ0gKiwt1g1RfbWtP5hZ98ArDkIT7J+5
         x1kQ==
X-Gm-Message-State: APjAAAVAVEQoGs1i3NQlG61RMd0aEJHxCvTwH8EG9zr3IsJHc22KowmP
        JmP+Mn7qx42QFv3ydvUNdhI=
X-Google-Smtp-Source: APXvYqxyY0FsNBQ5B+M/BIs5YSCj7DolLdF+U+1m/LqeKimNoBvyR/jhYgObE/XP2knI26kfXxHYEg==
X-Received: by 2002:ac2:4945:: with SMTP id o5mr3190816lfi.93.1575391203989;
        Tue, 03 Dec 2019 08:40:03 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id h7sm1675207lfj.29.2019.12.03.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:40:03 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1icBDe-00019s-CR; Tue, 03 Dec 2019 17:40:10 +0100
Date:   Tue, 3 Dec 2019 17:40:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        JohanHovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org
Subject: Re: [PATCH v4 0/2] usb: override hub device bInterval with device
Message-ID: <20191203164010.GG10631@localhost>
References: <20191203101521.198914-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203101521.198914-1-ikjn@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 06:15:21PM +0800, Ikjoon Jang wrote:
> This patchset enables hard wired hub device to use different bInterval
> from its descriptor when the hub has a combined device node.
> 
> When we know reducing autosuspend delay for built-in HIDs is better for
> power saving, we can reduce it to the optimal value. But if a parent hub
> has a long bInterval, mouse lags a lot from more frequent autosuspend.
> So this enables overriding bInterval for a hard wired hub device only
> when we know that reduces the power consumption.
> 
> Changes in v4
> - use of_property_read_u32() instead of of_property_read_u8()

What changed in the previous versions?

Johan
