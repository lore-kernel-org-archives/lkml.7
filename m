Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9682084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556311808;
	bh=GthxEJ5iSdNo68ZWeeQ3saP4TVjGgTFhhan+giZ7IZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pu8QeJq2bnYpchXUb/bhYGtU/NA/BM2oM3RRXWpTLpFNcOUBZ8yDTkhaujDE54vFh
	 eCfQEDt/Ncnb8D2t7ccmtMsAjolKpxfRQC6SA0iXM4x5X+3vqIJXuBrn8fgXtvuKAu
	 R/uHllhXXc3OJZpdbb71uOkfVfeU6rC0X+gY2WVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfDZUuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:50:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33694 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:50:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id j10so3836998otq.0;
        Fri, 26 Apr 2019 13:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QNbysvp/LuY/94pU51W8fskOUVWUjWKtQqWNOsTdOxQ=;
        b=GgYvQC4ombmbeW0F8v7kjROkFzx3y5CUTays+Z6frg73gwWhDLla2kk3Ma05oGXV9O
         nVG/4vjWb0HZM0Ui5rrh5ff2QeJoqMBZdQoavFXWgfQ++bR+s+ARRZ4LdEDKbV9Mo5L/
         oAyK9jRkaruTxRcWtlAbsTVJrN80HUbKuoQm5RQnYKxICAN++C5gxAUy2ByIbEAgyMe9
         EMi2R0yqW74TvEj9fG/AORxFoCUU5j5iGxnW3Q1jU4wlyY0QKCYCcPlsEA2HEDiBUmWz
         MxNRcnE+ECQ6q6AvihBdPO0MPov9aBzPL8ojXhCpA+wn5bI5VMlsp+JePRm4EFJcgpOO
         bBOQ==
X-Gm-Message-State: APjAAAXkQcAa1IVuhGW5VIN/Dtpk3RieeZJU5XugQaDhDgxiGrbl79G0
        1M7/NyAuKRLyeqA8ptdn4Q==
X-Google-Smtp-Source: APXvYqwKGI81Nk3lEDA9EW6l8iRg5p11nZQUlg6X1cRp0JzdG1WON3LtpfXm7BBAjhZTHoYwqRPKiA==
X-Received: by 2002:a9d:1:: with SMTP id 1mr30316585ota.276.1556311806306;
        Fri, 26 Apr 2019 13:50:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 30sm12265862otq.62.2019.04.26.13.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:50:05 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:50:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, thierry.escande@linaro.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: bluetooth: Add device property
 firmware-name for QCA6174
Message-ID: <20190426205005.GA675@bogus>
References: <1554368908-22017-2-git-send-email-rjliao@codeaurora.org>
 <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554888476-17560-1-git-send-email-rjliao@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 17:27:56 +0800, Rocky Liao wrote:
> This patch adds an optional device property "firmware-name" to allow the
> driver to load customized nvm firmware file based on this property.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
> Changes in v3:
>   * added firmware-name instead of nvm-postfix to specify full firmware name
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
