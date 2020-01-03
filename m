Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BEAC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C10227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRhwoNEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgACSXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:23:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36031 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgACSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:23:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so5023789pjb.1;
        Fri, 03 Jan 2020 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZdYMbHHuye3OxN4qNu4WXkvcF4kb0+ArW4ikmrpnkyg=;
        b=RRhwoNEHNKdZBed3MGjUbtv4ggZsqjGlhjOsqRC3gyMxCSlk479RhFNvaVHNh/0YVP
         16loWVe06uuTxhDS8wWEuQvhqE4UCs3fPOrOslkjLdZUpa75KxTZjuFrZynCsn+73EL+
         KdHNJyjEHr9En45M14OnGXJ9FkyA30+G7YLcpK+UcEgR7dkwsn87Gyy7ICE1WQhh0f5f
         AQ5G/uo3yxH3xDpfsSlxb2VWMWlCvYeynRcgYfYrW0H6YQMx5Dbge2VystSvTKORHR8d
         o3bfRs6wD7KWluSdTar7EEPHvwlgg5MQHCKbVQTR+zQTuytFmPzTUT5ybLukb5xnwzVn
         rdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZdYMbHHuye3OxN4qNu4WXkvcF4kb0+ArW4ikmrpnkyg=;
        b=Dm7TtBoO2SLUGEn+KOWSJ5btEuLVQ9N4tn90RECLClMsywyIe9YB1DyKwOsJKAORyN
         ZxzK8QyZegYpnpjQv/9wh4k6OmhyQL8LucByF53KCFzILLCkSJAGm8L/XkNtDRing4fh
         vA9Zeal1K/Ulvn0dcXw5qZYXPpWhkU3yPAKeFW9Alnio7aJjB6iYFIr38mVW9CII8HPn
         gnm9fLDLK2p5mgUryJ7T01rrJmQX4H0y8nbbftgQ3rYTUYg9wWYHMI1ADOLAhfAtJ09C
         7tyNfLzRNxXWBmCdrybJwxJzHfPvo+26aPjQt2UDmaBipuc1gPr6eBLaitGmfzZyyWlD
         xTUA==
X-Gm-Message-State: APjAAAWyPdY6sZvRc7X70/tVATcVPfmjUU5gXlxhUBJrMYB2g0HQG9iv
        NwW9Fa/kd0P3N9qPYuuUoZM=
X-Google-Smtp-Source: APXvYqzQdQ96R77JEZw2yZkP47/YvYHEZbW7XKu5xhz3IWJ0sF1759VsIGbrWG0DdSZEKyLBuEgzew==
X-Received: by 2002:a17:902:8a8c:: with SMTP id p12mr79573395plo.6.1578075832528;
        Fri, 03 Jan 2020 10:23:52 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l8sm15433322pjy.24.2020.01.03.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:23:52 -0800 (PST)
Date:   Fri, 3 Jan 2020 10:23:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: st-asc: switch to using devm_fwnode_gpiod_get()
Message-ID: <20200103182349.GE8314@dtor-ws>
References: <20200103012053.GA1968@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103012053.GA1968@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 05:20:53PM -0800, Dmitry Torokhov wrote:
> devm_fwnode_get_gpiod_from_child() is going away as the name is too
> unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Ugh, please ignore this, apparently I haven't compiled this branch...
Additionally, I think we can use standard devm_gpiod_get() here as node
is the same as the device in question.

-- 
Dmitry
