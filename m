Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5720873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g385mqhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJHW05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:26:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36889 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJHW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:26:57 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so581013iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/za/eHCc5YOxno3F960dEsfMKhLfXOAXTv/vlKJMoEE=;
        b=g385mqhhG3YqM6741Dr3UcBd275bV4bgqOgxgbtRSIeaKCso2qhjcuIJljO0DyDqCD
         vQxX+JHS+1UrGIA7/Vd4HDuE0qE8Kdo6R7AO8OX9T93Mg7GNMf+ZmQMCIedq/UhCl6yd
         jepHsXFKTIDl6ln/MSBaXdNH4PO6Zy3k06emw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/za/eHCc5YOxno3F960dEsfMKhLfXOAXTv/vlKJMoEE=;
        b=sfhxmF7UyYuvx79sDbNdSKVztSELs0xDz4bYZUkEEQgLt9tAO5DETQiC0ZQGSHtYmk
         IdyIg4fjN4nlB24r63+JgC6pIatDo5igh+/ARbLZAqxJwC+0eNgu2yYJUkH7IhDjOZLs
         QAqf0//uCcoVqnpoO8cmxJgH3IceDHnKZmfyxPXIjVSD6hFZrRDE34kxSDg+IiQk6i3T
         dSmHX1UBTu5is8/LlpqQl+CTJ6ZRJSu84vDSBp6CmA2LnDEBwSP7heOz6i2n6JYDuTTB
         pbD56KBiMdRzxP3Kprib7bmDjPHRFH4znufJCSTkluRWXe8qFC1Pp2Gtuhd3NKZI885y
         iskQ==
X-Gm-Message-State: APjAAAUJehvPXm9xzUOOTfMYs6jwPgzg+sPVTP702J/zhhqXYuZgkr+7
        GValbFgGbndrAhUMIljCHJzVSA==
X-Google-Smtp-Source: APXvYqzXddRYqKMm1dR+D3Qly2LRExHYiRLSWfctGIW1OxRhYNXxrwkIVbE0LxYj80sjwev4r6tcvw==
X-Received: by 2002:a92:910e:: with SMTP id t14mr655771ild.40.1570573614919;
        Tue, 08 Oct 2019 15:26:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id m9sm150981ion.65.2019.10.08.15.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:26:54 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:26:52 -0600
From:   Daniel Campello <campello@chromium.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, enric.balletbo@collabora.com,
        bleung@chromium.org, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com
Subject: Re: [PATCH v4] rtc: wilco-ec: Handle reading invalid times
Message-ID: <20191008222652.GA111471@chromium.org>
References: <20191004142608.170159-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004142608.170159-1-ncrews@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.
Reviewed-by: Daniel Campello <campello@chromium.org>
