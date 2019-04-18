Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58578C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE1121479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555568866;
	bh=Gs9sk7PgzQTWKeYUOKVYI7VvMxhH9NL/prm1kpp4UZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wipVf6uFkY4ldcy9SK7Vh1YmydlFsCPf8tcCI4xUM/KDFH/AzHQHRgdxa+/RN7Why
	 7dMEo0ltrw1nbwMPT+UDPOOB7VGUyLp0+nQVGBPPq66ANaBB8XmK77WxkTmjWuAt2l
	 zYVgh3+UwqeYq4dvhQoW3nQzrcTQbR1nLHgcgf7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfDRG1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:27:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44159 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfDRG1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:27:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so857937ljg.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 23:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=27hZ/6sHfvasvY5lcyTXlWa+sb/E6M6lsS1lqw59YmQ=;
        b=HF2c8Qh+yiJBOUJ4ZsqyOf37Esm1CHKbuZDQl02tcpxxgG7CVxDhdWrDxxBP5sLK8T
         P+MaFPq0CDA//aDD0y80uuH+sHPx4Vhvz/hKNrtCXjMDo2JjwzK08tvXK66DWGKucuYE
         5316UTvGZXO7D3Z3bgEyv7tnURCGaDymiIq/QhlzuVBkOU3iwwnOq1zQ+n2supqf565P
         Rr8Z4MG+2yOyRMBpsthuHnvUMeDF+8O+gLkWsfL0EIEM1BCK1uC4PXUFe1SwPBN24Haf
         3rGxFUT4yagx1xaw1JgvX+nt4W0dIEPJSHoiKOa6xxt543ezqmVLMzCMlGesGmiJxoL7
         ZQsg==
X-Gm-Message-State: APjAAAW3vBy/EP4+/PBCJ1TuG1itX2GGtFoNdsmemOniAeDbdugY+/NB
        pR2Q0qzsvnoFJBs8Q6PjMeI=
X-Google-Smtp-Source: APXvYqzKaOsn1nneIuDxknBDMWS8i2py8tx2bo3W9KItYrfahnIkzFXoN+dQA8v9Wth/iX+Bzldzrg==
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr27032206ljc.149.1555568862194;
        Wed, 17 Apr 2019 23:27:42 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f15sm239023lfa.89.2019.04.17.23.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 23:27:41 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hH0WU-0007NI-Jv; Thu, 18 Apr 2019 08:27:50 +0200
Date:   Thu, 18 Apr 2019 08:27:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: power_supply: use struct_size()
 helper
Message-ID: <20190418062750.GA28269@localhost>
References: <20190417184440.GA6025@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417184440.GA6025@embeddedor>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:44:40PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace code of the following form:
> 
> sizeof(*resp) + props_count * sizeof(struct gb_power_supply_props_desc)
> 
> with:
> 
> struct_size(resp, props, props_count)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Rebase on top of 47830c1127ef ("staging: greybus: power_supply: fix prop-descriptor request size")

Thanks for rebasing.

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
