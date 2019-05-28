Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A3EC07542
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31D208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=babayev.com header.i=@babayev.com header.b="VTiNwQT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfE1C0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:26:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38058 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfE1C0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:26:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so9987985pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PbAlnbMG3ZQsuTiPzcj5dR2K8h+JQcEEAbcsQKzHrp8=;
        b=VTiNwQT9ngEv4fGQldDwmwNpeLWpsu6SR50x7OfHNIq+PZbu2FxUchJjUWpV1KG9W7
         +O09yXGsURhBHPPerTLS84kxR/Ze8kuYI75fVsmtS0eaDe9+r+frVodGkjQ/XNg27AZm
         Q5Ojd70jtTWIhCAD1gkxDMePKzeKRwyRrUmuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PbAlnbMG3ZQsuTiPzcj5dR2K8h+JQcEEAbcsQKzHrp8=;
        b=rMJQdyuIyTEpfRWT++DO0qbW3B9mqKLBBWWAh83yg6ndcOn0Hxz4hjaqGcJz4lxxz5
         kztH34d/NobrzS9g/Ru+0S6O7YOWDNQGMY0MA06YQEybX8hU5a6gYysL5INaKy7b/z3V
         3p95vicd6dBwHoNDK6CW0CFx0idDL+NDOGAcZYHGs5Iwjx1Oldngx5vQRcfS/6K3bCks
         d8K6lCOAHeRsXNBCzF5Wup8jbpmpkO+zCPEkb43v8Jlg/0WHbNIsng10RU4LOiKVHw6l
         8gYVmgzj+0zge6J4kWxJXJtxP2dPld1mcAse5Kp6FMTDWe3UqUyJ8MHcgZtf2usN0P5Y
         SrwA==
X-Gm-Message-State: APjAAAU0m1Qr/Osl5fyV0ylKG/1NeSe1vuVcPCohBfHuXilQM1x0bn7S
        Pl740NaZrc19YzXjwl1Y13FG+g==
X-Google-Smtp-Source: APXvYqx+VY3FarvHW7iBaypvG6dz7YPmC7OnZveSMATrcMjnfNcPSxPUaSYfs1JcSyOp5shSR2CCYA==
X-Received: by 2002:a17:90a:bb8d:: with SMTP id v13mr2260630pjr.79.1559010414042;
        Mon, 27 May 2019 19:26:54 -0700 (PDT)
Received: from localhost ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id l38sm720404pje.12.2019.05.27.19.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 19:26:53 -0700 (PDT)
References: <20190505193435.3248-1-ruslan@babayev.com> <20190525005302.27164-1-ruslan@babayev.com> <20190527083943.GX2781@lahna.fi.intel.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ruslan Babayev <ruslan@babayev.com>,
        Wolfram Sang <wsa@the-dreams.de>, xe-linux-external@cisco.com,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
In-reply-to: <20190527083943.GX2781@lahna.fi.intel.com>
Date:   Mon, 27 May 2019 19:26:53 -0700
Message-ID: <8736kz9uvm.fsf@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mika Westerberg writes:

> On Fri, May 24, 2019 at 05:53:01PM -0700, Ruslan Babayev wrote:
>> +struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
>>  #else
>>  static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
>>  					     struct acpi_resource_i2c_serialbus **i2c)
>> @@ -996,6 +998,10 @@ static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
>>  {
>>  	return NULL;
>>  }
>> +struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
>
> This should be static inline, I think.
>
>> +{
>> +	return NULL;
>> +}
>>  #endif /* CONFIG_ACPI */
>>  
>>  #endif /* _LINUX_I2C_H */
>> -- 
>> 2.17.1

Thanks Mika, will make the change and repost the patches.
