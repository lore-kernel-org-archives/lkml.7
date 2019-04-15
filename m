Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91697C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEAF20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqW8J2yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfDOWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:32:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46654 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfDOWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:32:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so9258095pll.13;
        Mon, 15 Apr 2019 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iB7ZNzzdil/xdj7cv7uy536/PxeJkN+z355Fttznfc8=;
        b=hqW8J2yM0Kx/jsDxBUqtJTJk7t3Oy6/96GSn2B6/0nB8pEPCNm2Ajlx6S49As0MYRs
         VlwusQ1islGYAjxpHG0MOfaasBTsdBpOtz3xQzwd8KL6OG+DXXtqk0IrSf4R/d9rqkQs
         7/KEDaDf554PrKT8X4zoZNlr9005Zq/zVYE4gUad2CugMe85wEGgjR6Uql+lirsx+Th8
         aeYFY+YojKgOIn4iZ4v3fj6nKWT26KmverYOhZbx7N+vWnMnQtLO0nxDhto9+xNXpjo6
         uad06oLc86doZTZBoVJLcI91Ce5FNzRXEoeI46mje9tR/vf6WYPMi8OePwVt1pZ6SSxt
         K9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iB7ZNzzdil/xdj7cv7uy536/PxeJkN+z355Fttznfc8=;
        b=FWXrMxUbTyoK58N5BfEC3W8A70SklFDvRYBSwQ8yM5GG01DH6g8euT8vvDQqbis973
         KxFjSrTNbAYfzCy8VxuUO6EK1QrRnvrYgp5kuWrzWVWvvTSBscFf+qPwsaFxHOlb1cG9
         3nZ02mzyKo/beYcKLDGptFWj0/2R+t7GY/wmVSo/q9MbpCTmrnrNyI9grRDXqo9GvyRn
         tnOBE26oGzkKdeRHYXyrFo294jU3nRD4o/u06KDcgLRDPUS1LtG5Hz1wl6u+94VcF3Wf
         y2zr9TQpzW5Ofs3XV0DswEmHAY7PTxAcaQMIq3lCNkfsjApUX4jMC0CFTeMgzZGzaBTK
         umkg==
X-Gm-Message-State: APjAAAWjbHcRRXNh0pTz/P292Nq8q/TaMQYICmx+AJRi4pEjOUhaBYKF
        pWO/18lNaACfWrKQDodmyvk=
X-Google-Smtp-Source: APXvYqxaIRiXqujWKLNt3jlLxJLgIHrN+pSMYg/iICMtnL8vj1lv7w1HjyKh5bw49p590e2m9Guwag==
X-Received: by 2002:a17:902:e183:: with SMTP id cd3mr62543540plb.233.1555367577116;
        Mon, 15 Apr 2019 15:32:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a6sm70266531pfn.181.2019.04.15.15.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:32:56 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:32:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Patrick Venture <venture@google.com>
Cc:     jdelvare@suse.com, joel@jms.id.au, andrew@aj.id.au,
        Maxim Sloyko <maxims@google.com>, kunyi@google.com,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Lippert <rlippert@google.com>
Subject: Re: [PATCH v6] hwmon: (pmbus/isl68137): Add driver for Intersil
 ISL68137 PWM Controller
Message-ID: <20190415223254.GA31193@roeck-us.net>
References: <20190415222807.134104-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415222807.134104-1-venture@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:28:07PM -0700, Patrick Venture wrote:
> From: Maxim Sloyko <maxims@google.com>
> 
> Intersil ISL68137 is a digital output 7-phase configurable PWM
> controller with an AVSBus interface.
> 
> Signed-off-by: Maxim Sloyko <maxims@google.com>
> Signed-off-by: Robert Lippert <rlippert@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>

This time it worked. Applied to hwmon-next.

Thanks,
Guenter
