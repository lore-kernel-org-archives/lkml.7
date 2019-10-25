Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF694CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3067205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G1oGiG8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505934AbfJYRdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:33:23 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40458 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502736AbfJYRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:33:23 -0400
Received: by mail-il1-f194.google.com with SMTP id d83so2524434ilk.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/za/eHCc5YOxno3F960dEsfMKhLfXOAXTv/vlKJMoEE=;
        b=G1oGiG8O60afGke/KjUgd2tG/RdjqxXAI0+PdQzcUIRvQRnmMrIFdCL/v8qDg6c3CY
         Uml6mrI/c3Ct2PddLdPAdrlP8XOvds7Kjczg6z+MN2NjD53UMqlsGqIYqxlunNtwGZi7
         gMBK+/G6/9TkEaxeOFC6MD3hqc8rUsfNvMZ08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/za/eHCc5YOxno3F960dEsfMKhLfXOAXTv/vlKJMoEE=;
        b=OblgQe+nGLfTg7PVx2i9r6rA6EYzJuIUGbzbxcUWuNe+UWvNBQtiC76FE5QTzin3F+
         JDFKORLylgyH489cMGzHAHxCmthorkya9RsxdJAAkRs8ZL6kEqvpbhkxRxejXo9rXMo+
         CIdrku2Ot3bBvw0TdKOLyQU/AXYhzS8wmyIoVus36P4PThybtSkdUcXKRV3PeeDOPpGg
         YrsOwu+fLCrSsdnJZu5FXG9UKU+Y9UygUAnVQd9ZZNM6eHHX4UcgiX4zn0MWszCt+kWr
         5bAzRyYFw5sN9Q0ZGff0AdMatWsy99pgAXHOlSGdjd+1d/iMLUSrf28yplG0sCpGJLlD
         zphg==
X-Gm-Message-State: APjAAAUouR8UHSEnJFOZUooYFfsH01AUISk9BHknmXynxetK/Ywo2Fxn
        nqXd57ddZdGEtRYMf4AbdVi6mw==
X-Google-Smtp-Source: APXvYqwGcZc8kYV3Xx1MurQC6XjEHeqdTcoIEPkiFtkiiNBLe9vEJtobGEUW4cUDtxm5+8pjifmQ8g==
X-Received: by 2002:a92:580d:: with SMTP id m13mr5299155ilb.117.1572024801694;
        Fri, 25 Oct 2019 10:33:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:5d69:b29f:8fd8:6f45])
        by smtp.gmail.com with ESMTPSA id k3sm34224ilg.27.2019.10.25.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:33:21 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:33:19 -0600
From:   Daniel Campello <campello@chromium.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, linux-kernel@vger.kernel.org, arnd@arndb.de,
        weiyongjun1@huawei.com, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com, sjg@chromium.org, groeck@chromium.com
Subject: Re: [PATCH v8 1/2] platform/chrome: wilco_ec: Add keyboard backlight
 LED support
Message-ID: <20191025173319.GA1768@chromium.org>
References: <20191024222805.183642-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024222805.183642-1-ncrews@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.
Reviewed-by: Daniel Campello <campello@chromium.org>
