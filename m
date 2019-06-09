Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B14C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19119205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tx94w3+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfFIQx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:53:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34707 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbfFIQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:53:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id q15so1551399pgr.1;
        Sun, 09 Jun 2019 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VlNF8neRI0nw9XEMnVceaIeivPxB/S7CyWZXCdEDsCs=;
        b=tx94w3+b4ucLl04HofbpsDZolPVN89TBIVubZZeE5sjQUUyC2PWuBz1y8pUyNBtKuL
         SoEuo1lPAEwgw+BMeiC3U12lmAOQo/kk4CyWZ6QCF4egNYXG5y5upkxE32Wy3Q8s3w7u
         1nIYHAx3qm2NQjWhb3XBav9pZlLkYkcluL+lQDjOsHuL06a+2eJh7HNZAFzLDuWjCTIj
         sCzAuUa8M/DUlZObzqPajmcQo+gii3M/EPjwN48BSh8Eflw/Vr19D1rsUXe9W0mh9jsO
         P91bFqyAZvI5qXbgNAc7hucNCFMfciEWJ495+ih9fHscj3AAT489sGJNO8xPd/rYTohR
         eTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VlNF8neRI0nw9XEMnVceaIeivPxB/S7CyWZXCdEDsCs=;
        b=FdhWik1nFgGf4lHZkAb9nWZixNrqThKGlCYDsZbpVmqt0WsRTN+OxMPtGVZkT6A01B
         5pkWVAtBhInjYs+a0yFJWHNW+HVtfhUmFsHRyxUH+tzCcDo33up/xbgFJJlQ27NFHZtf
         h+GAzIFIvz6QZposusGbdxR9JrmOqOq7w+S4hiGfudZG5djyJC0c9AIPqthjToIhroim
         oYrKga5gDXViPWlOocQdy9au9LB7EYqTN+dGSR/2qQNINDB0DOQxzWE8zA14D7pgtItZ
         2+/LrLRNiskHnuctbI222SkIJswq+l6qYMHl3cBGUWwJZWLXzEVfEtPAmzzcpHxRS7a+
         B5Dw==
X-Gm-Message-State: APjAAAUWfTq63MdimFUAesr015yOhs6tPfuAlwMKxdVg4Nx3+O3p0TRa
        P4+R5iRVDUjiakb9w1dkDF4=
X-Google-Smtp-Source: APXvYqzX8iWGRN1vGe0kbA7DTcRf5ZzmvjjpbXjifik2cd0hJsoD1uVNcmv7byO5TOgXJzjZqxn3RA==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr12211976pgs.343.1560099202186;
        Sun, 09 Jun 2019 09:53:22 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c6sm13686904pfm.163.2019.06.09.09.53.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 09 Jun 2019 09:53:21 -0700 (PDT)
Date:   Sun, 9 Jun 2019 09:53:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheiny@synaptics.com, aduggan@synaptics.com,
        benjamin.tissoires@redhat.com
Subject: Re: [PATCH 2/2] Input: synaptics-rmi4 - export nosleep of f01 via
 sysfs
Message-ID: <20190609165319.GA90002@dtor-ws>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
 <20190220164200.31044-2-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220164200.31044-2-aaron.ma@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Wed, Feb 20, 2019 at 05:42:00PM +0100, Aaron Ma wrote:
> Some of ThinkPad X1C6 touchpads didn't wakeup after resume.
> Forcing enable nosleep make touchpad back.
> Add nosleep via sysfs, so user can control it to workaround issue.
> 
> /sys/devices/rmi4-00/nosleep can be written non-zero will enable
> nosleep mode.

I do not think that noseleep attribute is a good solution as users will
have very hard time finding and activating it. If nosleep is absolutely
required, it has to be activated automatically.

However from the discussion on the 1st patch it is my understanding that
this patch was not really required, so I will not be applying it.

Thanks.

-- 
Dmitry
