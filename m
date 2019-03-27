Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94775C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E892075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715156;
	bh=rWA4zj/Yc6L8wOMv0EVMiytiMPl/7W97iPgDoHRXJrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eabQgkxyRNNFSQfv5XSfjIgavB/j7yhgc7LEhDG9XBIx56yQbDFTAn4XNmvG6lVWm
	 C0/S2gDfvO7SJNtuh+Cgy7+4UpbovNENoUOCvst/0fBlOCKfz5iswRCcL30xVo2mVk
	 yxCi5xHtgYQozlqtg2FIawhZUDwm0oLX1xlWzKA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfC0Tcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:32:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42619 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfC0Tcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:32:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so16021271otd.9;
        Wed, 27 Mar 2019 12:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/QDaw8G74NauA5Cf2QjKl6ZVF3JATYOdJAxmTVtmQE=;
        b=B0+SNyN0WRtP00AktNhlk0pUB1JkSx6DVslx7hkFktBkaC1b3yiuM/G6k+9nH7xK+2
         NyxanHogdCEn5ofEq7rygxDgP5KL4evSuo5pdpzb+Ee2Wt0iKb/3YN1ve1QCQ2ZncacF
         3paOc4ru0sF5nZaHTDbsveI89uEvcks2Ytgxe1RRRWyozVV4O+GRBNnZBocqpwnPZPCL
         JBzRwv/jQZ6lY+hdlefrokBd2BKqWRf35/KWBnxELtIYcMQq42WdcZLtMqOpTCfaWF8F
         JCWOEHNQgeaiK/LuwO13S/QQxa1F/0JU9AND2gXQBSHKk6D25VDsQ9IXtlw47ZvDIj4P
         XyVQ==
X-Gm-Message-State: APjAAAXL9Oh70EbT243ZfEEuLluNR21gvSo0cO8ryHfUoglwFMLBLyzV
        9Oul91jv2Qx9FLEdwESnyMozzF8=
X-Google-Smtp-Source: APXvYqxBsC10iSCj2wgdhee+UqYQhvFnyaXdkkguatLoMauB5FatbSp85tcs/C6kTxZeAPtZ2VhqyA==
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr18548639otq.321.1553715150952;
        Wed, 27 Mar 2019 12:32:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f26sm8887835otl.20.2019.03.27.12.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 12:32:30 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:32:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: add non-removable-ports hub
 property
Message-ID: <20190327193229.GA13745@bogus>
References: <20190228184540.24570-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228184540.24570-1-mans@mansr.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 18:45:39 +0000, Mans Rullgard wrote:
> Add a non-removable-ports property that lists the hardwired downstream
> ports of a hub.  Although hubs can provide this information, they are
> not always configured correctly.  An alternate means of indicating this
> for built-in USB devices is thus useful.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
