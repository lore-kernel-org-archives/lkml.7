Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01162C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89A620872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 02:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHU2wJYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfDQCLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 22:11:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43254 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfDQCLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 22:11:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so11231936pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 19:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UgRKV9T+QUZ9K4sSpZTZHhjPCRSdW3urBZhxxNI954U=;
        b=hHU2wJYtiaeDFjKNYh79inwr3ENOgLdToYNWfM7KsIGmGuY8S9UI+E2yR138ZoJCvM
         4n8etiHiDD2SxDfjZXj8BYBpEeYb+IqYMhOEywc0hCte/qClNpFoBaZnyq6c39E4N0MW
         KzpsAmDXPiak5UKdcbjELe/MZOV5fOoZXr79JQfCzUoGWh6SaMb2okB0NnyqSbFrGQxS
         rclQnq3VeyJa2Si01RLMzyZkd7arMt9Bg5ydHTyiNvAVlIwKecqxS03xoEvwvb8uh6Pu
         mL+svJgFM+ngFrWTf8r1QxTT8wfIs2cQ8V7GRlFSmGsG901eoPm6YjUPpBYBFHWwi0uG
         uEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UgRKV9T+QUZ9K4sSpZTZHhjPCRSdW3urBZhxxNI954U=;
        b=fcv/XL1Nsc6oeRFBvqqUrZbo6bqHe2Yzrcmn5yCiEnEWTncUQZ9h9DAaWbTkXn+7QR
         3Y6x922ggMH6HdmUBpSPNWQLfW4eNG6MprqHcjzDihsfIcQWLnAA12kW16QadUZ0kctL
         2W3VZP80rOSnCraPXSiPZM9ylH2tawHcq0y3zLJcCcX4lUsBbG2aTp7a4QGqM+hIOkVf
         w5xpGj2jbDYz+PPKZnR0q0O9Ocrr6S8A+0UvJNgMAax1KedSBvgrdRZsqdo8tXXK+nPA
         5IobUUZ6/YZ6Qd5PDtZ2OVan1lcXVxgaMS3Pj5kkpLdMihDuegktGXlHFo9UgQp+/+BC
         YbWg==
X-Gm-Message-State: APjAAAUL8ffaYZ7m+scUfPjcUlMR/h+XmrLitVmBabBbQHnogp1bUohH
        V9IGy/scF11Q8C+X/PyukFICsutkL1Y=
X-Google-Smtp-Source: APXvYqw6CB+IlmFuK2I63bAdG0hWkyQpZpXIjNZq+F8YxYINJHhtD3RauPzdR4ROxFdhGQ+IxNXwQw==
X-Received: by 2002:a63:6942:: with SMTP id e63mr80884728pgc.102.1555467099359;
        Tue, 16 Apr 2019 19:11:39 -0700 (PDT)
Received: from localhost ([43.229.100.82])
        by smtp.gmail.com with ESMTPSA id j19sm66073141pfh.41.2019.04.16.19.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 19:11:38 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:41:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH v2] Staging: greybus: Cleanup in greybus
 driver
Message-ID: <20190417021135.ow5mmua7cdusnph2@vireshk-mac-ubuntu>
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416221318.21161-1-madhumithabiw@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-04-19, 17:13, Madhumitha Prabakaran wrote:
> Fix a blank line after structure declarations. Also, convert
> macros into inline functions in order to maintain Linux kernel
> coding style based on which the inline function is
> preferable over the macro.
> 
> Blank line fixes are suggested by checkpatch.pl

This was all intentional and we use such macros everywhere in kernel. No need
for such a patch, sorry.

-- 
viresh
