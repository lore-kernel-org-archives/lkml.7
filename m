Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA57C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C552077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1WO7mxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLJFew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:34:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39669 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfLJFew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:34:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so6813769plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 21:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzsFieC11fwzabgMCPx3URH9lCYXYANqoMZZrtmqKd4=;
        b=L1WO7mxjzK/1efDe2pAT51plCIrpplQlmPc9fY3UGwPV0+TH9blV6G33+mD8zglKW3
         rkcbOyGgtLxlkk9Akv+WgrJBQEtcDaX1pl2SD/p3kT7wsE3bEDNv39n0aopK1MVX6qSH
         X8EHOAOa4/nJWGU295R15Fs6gDthazw88muc2WC6EqX0Q9QrGUXJDJY35HPz7YJ9sE4J
         /4UTcXRkCAaBbXn9JNWbrQqIZrCBF3jXXZt0oVf1fhw0v3ArsxzfLVUiUPpgZLcsjOuK
         MO6UQ/WDFKGYQZ59h3mRcx72WAbgXhN9hDhki6zlNGy7wZFi0cQDj6Q/c21honCae8gT
         y0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzsFieC11fwzabgMCPx3URH9lCYXYANqoMZZrtmqKd4=;
        b=nCIVhxUqV7G0+n3vAwQ7eeTpP8yIF3+QgwlH71cpS9idPPwKWfpf7mlvRDxwdRh29u
         gY6dM3POE+qtgKkvSkaOOIYkn3tNLeFCP+MSdlrvAIYT80mzvVqTotm1uot3Y1QWjIDY
         v78EMjtxmnvVezY5uq9g6V6r+WdLcjUm4fqTs8AiVeLUtSmuIlH3QL9krL2d6UZ2BdD/
         7U65+FMmyUXSwKndvnSp44NgM7cvB9VJJxWCbEiNKQAabXzBGKpXRQ1Mb5qSdZ45Ilto
         Nnhp96ZoP6dHf3y5k0God1MmgPsJIfWNZYW8AistCCEg7hAFuQ8NJjJ7g1gTtgsyKeZh
         zHtw==
X-Gm-Message-State: APjAAAU1a4CrFivD479qqYL4gVHwdyiJnKlf7Bq7cagcY273JCAiN1n9
        Ci0CI83kDnQ7pFaRufy2tkm5wRUbGRk=
X-Google-Smtp-Source: APXvYqyQah584mrSQjBTpa6c9+I7UIqTgabaisZdQnj71yPkC7qJrT6b9DaMBWRuH6z2dHKhTzAUOQ==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr3499127pjq.106.1575956091524;
        Mon, 09 Dec 2019 21:34:51 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id y62sm1428047pfg.45.2019.12.09.21.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 21:34:50 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:04:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20191210053448.ugjzbp2puzvnm37f@vireshk-i7>
References: <5c545c2866ba075ddb44907940a1dae1d823b8a1.1575019719.git.viresh.kumar@linaro.org>
 <71417ba8-b844-ac96-bcad-4bf48fa8b869@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71417ba8-b844-ac96-bcad-4bf48fa8b869@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-19, 18:13, Cristian Marussi wrote:
> On 29/11/2019 09:31, Viresh Kumar wrote:
> >  /**
> >   * struct scmi_info - Structure representing a SCMI instance
> >   *
> > @@ -128,6 +109,7 @@ struct scmi_chan_info {
> >  struct scmi_info {
> >  	struct device *dev;
> >  	const struct scmi_desc *desc;
> > +	struct scmi_transport_ops *transport_ops;
> >  	struct scmi_revision_info version;
> >  	struct scmi_handle handle;
> >  	struct scmi_xfers_info tx_minfo;
> > @@ -138,7 +120,6 @@ struct scmi_info {
> >  	int users;
> >  };
> >  
> 
> Could we add also the related @transport_ops in the above comment block ?

Ah, I missed that.

> >  	desc = of_device_get_match_data(dev);
> >  	if (!desc)
> >  		return -EINVAL;
> 
> This scmi_desc struct descriptor is retrieved from  of_match_table .data and points to
> the driver-provided scmi_generic_desc
> 
> static const struct scmi_desc scmi_generic_desc = {
>         .max_rx_timeout_ms = 30,        /* We may increase this if required */
>         .max_msg = 20,          /* Limited by MBOX_TX_QUEUE_LEN */
>         .max_msg_size = 128,
> };
> 
> Is not this kind of information possibly (maybe partially) related to the selected
> transport, and as such it should be also provided dynamically by the chosen transport
> layer at probe time, like the transport_ops, instead of being hard-coded in
> this driver ?

I had my doubts about this thing and I missed checking it out.

@Sudeep: Is this information completely mailbox specific ? Should I move it to
mailbox.c here ?

-- 
viresh
