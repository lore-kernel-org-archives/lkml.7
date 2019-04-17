Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFAFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF11E20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogVeuicY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbfDQLlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:41:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41713 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfDQLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:41:35 -0400
Received: by mail-io1-f67.google.com with SMTP id v10so20272250iom.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EDbRpCydC3S6vLeF7++IiUU+jHXgnsSgM309DC1HEbY=;
        b=ogVeuicYeqvOQG1GVM4a47BREt035jGHJSznG2rAcem3fpMrUwO+oVlKTc7UXrV25v
         ZlGtNouiPwMoRjROZq+oKdhUfaBzQ4aT5RZ8GHstd8qQQTpUsGXI/lawcazeBPC7SMq7
         vqW1u9XOSiY9ZESLBiIeR+8hzBs3qmwjnCysihWiWFIzOgzVf+vwTce7dNA74u3rXoyX
         81oRLh1/oWCqNnHFx6469NPyAj6bEQvsRNC10U7qGVrtImtEZE26n/dVoMcGshGty5tK
         tMhq9RjnYl7emFeqXIKygKXvQypx4WDZ/qhEM/zkvt8GJSgGJsyJupu0QjwhdmSrqcNG
         P/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDbRpCydC3S6vLeF7++IiUU+jHXgnsSgM309DC1HEbY=;
        b=bLJumNEJ74xEnm+RbzAq7C5052m7WiPGBU30rWYhLxrWxUAYQkVvVHh3UBIRaNJhop
         O3b1lXtjmhYJlIa6B5qubco2nQ29npjtEdp+8JF/uteCPN4jmP58q9KUz/hns5KVZMkP
         ceWulQ49qxYRuQdjn/1XdfrXOm1BAG0WorqyIJ0X/ZYbk9+gNIVtsncLKThwCaOGZIfU
         I8s3zjf114SwOTimZpXq4qNDmV/YLPU8OSCFxX7tuKBh9ti7v7iCbFhcRKVoiYdCsLqz
         0NZxf8nR/9tt5XZ6i2FeQ3v08yBW5QZYmR3cMY6CRV2oQJI/vHvTdaJk5C2Hsm0C0PHG
         AAXA==
X-Gm-Message-State: APjAAAXUM/SpC6oG7aYMfBH7yJQeYOaHrN4XW3cdwHbFXhWpJyWmNyFw
        BelONhvBAjHvjzBAEb8YFruvTMSyjhc=
X-Google-Smtp-Source: APXvYqykzRKS4xCx7aGmskZH48M7WCcfq6/wHrtZ8F4ElkYBmwk06GHvvqe8WFXTxpH9Ovl1JgcfBQ==
X-Received: by 2002:a5d:9947:: with SMTP id v7mr4236930ios.25.1555501294316;
        Wed, 17 Apr 2019 04:41:34 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id v10sm19620620iob.30.2019.04.17.04.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 04:41:33 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH v2] Staging: greybus: Cleanup in greybus
 driver
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190416221318.21161-1-madhumithabiw@gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <b7ed0505-0ebf-98af-7beb-08b0709cc5fd@linaro.org>
Date:   Wed, 17 Apr 2019 06:41:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416221318.21161-1-madhumithabiw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 5:13 PM, Madhumitha Prabakaran wrote:
> Fix a blank line after structure declarations. Also, convert
> macros into inline functions in order to maintain Linux kernel
> coding style based on which the inline function is
> preferable over the macro.

Madhumitha, here is my explanation for why *not* to convert these
container_of() macros to inline functions.  It's not just because
"we do this all over the kernel."  The reason is that it actually
does not improve the code.

Inline functions are often better than macros because they are
explicit about types, allowing the compiler to tell you if you
are passing parameters of the right type, and possibly assigning
results to objects of the right type.

Here is the definition of the container_of() macro in <linux/kernel.h>:

#define container_of(ptr, type, member) ({                      \
        const typeof(((type *)0)->member) * __mptr = (ptr);     \
        (type *)((char *)__mptr - offsetof(type, member)); })

You see that ptr is explicitly assigned to a local variable
of the type of the member field, so the compiler is able to
check that assignment.  And the return value is similarly
cast to the type of the containing structure, so the type
compatibility of the assignment can also be checked.  It is
assumed that where this macro is used, the caller knows it
is passing an appropriate address.

There is another thing about this particular definition make
it just as good as an inline function.  A macro expansion can
result in one of its parameters being used more than once, and
that allows those parameters to be *evaluated* more than once
in a single statement, which can produce incorrect code.

This macro is defined using the "statement expression"
extension to C--where a compound statement is enclosed in
parentheses--({ ... }).  This allows a local variable to be
used in the macro expansion, which avoids any reuse of the
macro parameters which might cause side-effects.

So anyway, I don't think there is any benefit to replacing
macros like this that do container_of() with inline functions.

					-Alex

> Blank line fixes are suggested by checkpatch.pl
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> 
> Changes in v2:
> - To maintain consistency in driver greybus, all the instances of macro
> with container_of are fixed in a single patch.
> ---
>  drivers/staging/greybus/bundle.h    |  6 +++++-
>  drivers/staging/greybus/control.h   |  6 +++++-
>  drivers/staging/greybus/gbphy.h     | 12 ++++++++++--
>  drivers/staging/greybus/greybus.h   |  6 +++++-
>  drivers/staging/greybus/hd.h        |  6 +++++-
>  drivers/staging/greybus/interface.h |  6 +++++-
>  drivers/staging/greybus/module.h    |  6 +++++-
>  drivers/staging/greybus/svc.h       |  6 +++++-
>  8 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/greybus/bundle.h b/drivers/staging/greybus/bundle.h
> index 8734d2055657..84956eedb1c4 100644
> --- a/drivers/staging/greybus/bundle.h
> +++ b/drivers/staging/greybus/bundle.h
> @@ -31,7 +31,11 @@ struct gb_bundle {
>  
>  	struct list_head	links;	/* interface->bundles */
>  };
> -#define to_gb_bundle(d) container_of(d, struct gb_bundle, dev)
> +
> +static inline struct gb_bundle *to_gb_bundle(struct device *d)
> +{
> +	return container_of(d, struct gb_bundle, dev);
> +}
>  
>  /* Greybus "private" definitions" */
>  struct gb_bundle *gb_bundle_create(struct gb_interface *intf, u8 bundle_id,
> diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
> index 3a29ec05f631..a681ef74e7fe 100644
> --- a/drivers/staging/greybus/control.h
> +++ b/drivers/staging/greybus/control.h
> @@ -24,7 +24,11 @@ struct gb_control {
>  	char *vendor_string;
>  	char *product_string;
>  };
> -#define to_gb_control(d) container_of(d, struct gb_control, dev)
> +
> +static inline struct gb_control *to_gb_control(struct device *d)
> +{
> +	return container_of(d, struct gb_control, dev);
> +}
>  
>  struct gb_control *gb_control_create(struct gb_interface *intf);
>  int gb_control_enable(struct gb_control *control);
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index 99463489d7d6..20307f6dfcb9 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -15,7 +15,11 @@ struct gbphy_device {
>  	struct list_head list;
>  	struct device dev;
>  };
> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> +
> +static inline struct gbphy_device *to_gbphy_dev(struct device *d)
> +{
> +	return container_of(d, struct gbphy_device, dev);
> +}
>  
>  static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>  {
> @@ -43,7 +47,11 @@ struct gbphy_driver {
>  
>  	struct device_driver driver;
>  };
> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> +
> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
> +{
> +	return container_of(d, struct gbphy_driver, driver);
> +}
>  
>  int gb_gbphy_register_driver(struct gbphy_driver *driver,
>  			     struct module *owner, const char *mod_name);
> diff --git a/drivers/staging/greybus/greybus.h b/drivers/staging/greybus/greybus.h
> index d03ddb7c9df0..a82d5002b4d5 100644
> --- a/drivers/staging/greybus/greybus.h
> +++ b/drivers/staging/greybus/greybus.h
> @@ -64,7 +64,11 @@ struct greybus_driver {
>  
>  	struct device_driver driver;
>  };
> -#define to_greybus_driver(d) container_of(d, struct greybus_driver, driver)
> +
> +static inline struct greybus_driver *to_greybus_driver(struct device_driver *d)
> +{
> +	return container_of(d, struct greybus_driver, driver);
> +}
>  
>  static inline void greybus_set_drvdata(struct gb_bundle *bundle, void *data)
>  {
> diff --git a/drivers/staging/greybus/hd.h b/drivers/staging/greybus/hd.h
> index 6cf024a20a58..de7c49d05266 100644
> --- a/drivers/staging/greybus/hd.h
> +++ b/drivers/staging/greybus/hd.h
> @@ -57,7 +57,11 @@ struct gb_host_device {
>  	/* Private data for the host driver */
>  	unsigned long hd_priv[0] __aligned(sizeof(s64));
>  };
> -#define to_gb_host_device(d) container_of(d, struct gb_host_device, dev)
> +
> +static inline struct gb_host_device *to_gb_host_device(struct device *d)
> +{
> +	return container_of(d, struct gb_host_device, dev);
> +}
>  
>  int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id);
>  void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id);
> diff --git a/drivers/staging/greybus/interface.h b/drivers/staging/greybus/interface.h
> index 1c00c5bb3ec9..f86c0d596dbe 100644
> --- a/drivers/staging/greybus/interface.h
> +++ b/drivers/staging/greybus/interface.h
> @@ -63,7 +63,11 @@ struct gb_interface {
>  	struct work_struct mode_switch_work;
>  	struct completion mode_switch_completion;
>  };
> -#define to_gb_interface(d) container_of(d, struct gb_interface, dev)
> +
> +static inline struct gb_interface *to_gb_interface(struct device *d)
> +{
> +	return container_of(d, struct gb_interface, dev);
> +}
>  
>  struct gb_interface *gb_interface_create(struct gb_module *module,
>  					 u8 interface_id);
> diff --git a/drivers/staging/greybus/module.h b/drivers/staging/greybus/module.h
> index b1ebcc6636db..c427b788b677 100644
> --- a/drivers/staging/greybus/module.h
> +++ b/drivers/staging/greybus/module.h
> @@ -22,7 +22,11 @@ struct gb_module {
>  
>  	struct gb_interface *interfaces[0];
>  };
> -#define to_gb_module(d) container_of(d, struct gb_module, dev)
> +
> +static inline struct gb_module *to_gb_module(struct device *d)
> +{
> +	return container_of(d, struct gb_module, dev);
> +}
>  
>  struct gb_module *gb_module_create(struct gb_host_device *hd, u8 module_id,
>  				   size_t num_interfaces);
> diff --git a/drivers/staging/greybus/svc.h b/drivers/staging/greybus/svc.h
> index ad01783bac9c..4e35ac9ed0ff 100644
> --- a/drivers/staging/greybus/svc.h
> +++ b/drivers/staging/greybus/svc.h
> @@ -52,7 +52,11 @@ struct gb_svc {
>  	struct dentry *debugfs_dentry;
>  	struct svc_debugfs_pwrmon_rail *pwrmon_rails;
>  };
> -#define to_gb_svc(d) container_of(d, struct gb_svc, dev)
> +
> +static inline struct gb_svc *to_gb_svc(struct device *d)
> +{
> +	return container_of(d, struct gb_svc, dev);
> +}
>  
>  struct gb_svc *gb_svc_create(struct gb_host_device *hd);
>  int gb_svc_add(struct gb_svc *svc);
> 

