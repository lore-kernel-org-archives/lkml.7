Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB85C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D83207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 02:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivQk5tpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfJDC5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 22:57:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbfJDC5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 22:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iP8AD7OdNqS8eGAFdyLOUGy1xV4uS6CCHC335uf7mhk=; b=ivQk5tpAJ88grFGEnPXQWneIx
        mokpmc4qcST7AEAKQjpiJrpmNOwfN+j6hS5KVs0OPC02vjtaNvi4XP6Om9qavScb3Mohr64ZnOM2g
        qSsCeaso9txAxghsTqz3q5uKgP7MxZ3++92Ki+/xTyUt21dx44R1w7vL92tgUvP59qF6KXwkPzBJZ
        MJCVWyvoyNnpidjOhBSMRs75DYk0oCVAWxy2LNoHkI172PoTUm5hToE8pMkc8ulqJ/wWzI9Qr8k+q
        qSNCY5fPFcS9Vpyf4M4hKnAPCFYe3ILyPkZ4DqAI36ObpDggtbHFqgldsRVppZjggZaGS1q/cx5gZ
        C7Rjke3Tg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGDmA-00064P-Ni; Fri, 04 Oct 2019 02:57:02 +0000
Subject: Re: [RFC PATCH 2/2] software node: Add documentation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191002123305.80012-1-heikki.krogerus@linux.intel.com>
 <20191002123305.80012-3-heikki.krogerus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <910192ce-7a0e-8a26-39eb-3e6c0e3eb1bc@infradead.org>
Date:   Thu, 3 Oct 2019 19:56:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002123305.80012-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Below are a few doc edits for you.


On 10/2/19 5:33 AM, Heikki Krogerus wrote:
> API documentation for the software nodes.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/driver-api/software_node.rst | 197 +++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/driver-api/software_node.rst
> 
> diff --git a/Documentation/driver-api/software_node.rst b/Documentation/driver-api/software_node.rst
> new file mode 100644
> index 000000000000..cf8a05c34e9e
> --- /dev/null
> +++ b/Documentation/driver-api/software_node.rst
> @@ -0,0 +1,197 @@
> +
> +.. _software_node:
> +
> +==============
> +Software nodes
> +==============
> +
> +Introduction
> +============
> +
> +Software node is a :c:type:`struct fwnode_handle <fwnode_handle>` type,
> +analogous to the ACPI and DT firmware nodes except that the software nodes are
> +created in kernel code (hence the name "software" node). The software nodes can
> +be used to complement fwnodes representing real firmware nodes when they are
> +incomplete, for example missing device properties, and to supply the primary
> +fwnode when the firmware lacks hardware description for a device completely.
> +
> +NOTE! The primary hardware description should always come from either ACPI
> +tables or DT. Describing an entire system with software nodes, though possible,
> +is not acceptable! The software nodes should only complement the primary
> +hardware description.
> +
> +Hierarchy
> +=========
> +
> +The software nodes support hierarchy (i.e. the software nodes can have child

I would s/child/children/

> +software nodes and a parent software node) just like ACPI and DT firmware nodes,
> +but there is no dedicated root software node object. It means that a software
> +node at the root level does not have a parent.
> +
> +Note! Only other software nodes can be children and the parent for a software
> +node.
> +
> +Device properties
> +=================
> +
> +The software node device properties are described with :c:type:`struct
> +property_entry <property_entry>`. When a software node is created that has
> +device properties, it is supplied with a zero terminated array of property
> +entries. Normally the properties are described with helper macros::
> +
> +	static const u8 u8_array[] = { 0, 1, 2, 3 };
> +	static const u16 u16_array[] = { 0, 1, 2, 3 };
> +	static const u32 u32_array[] = { 0, 1, 2, 3 };
> +	static const u64 u64_array[] = { 0, 1, 2, 3 };
> +
> +	static const struct property_entry my_props[] = {
> +		PROPERTY_ENTRY_U8_ARRAY("u8_array_example", u8_array),
> +		PROPERTY_ENTRY_U16_ARRAY("u16_array_example", u16_array),
> +		PROPERTY_ENTRY_U32_ARRAY("u32_array_example", u32_array),
> +		PROPERTY_ENTRY_U64_ARRAY("u64_array_example", u64_array),
> +		PROPERTY_ENTRY_U8("u8_example", 0xff),
> +		PROPERTY_ENTRY_U16("u16_example", 0xffff),
> +		PROPERTY_ENTRY_U32("u32_example", 0xffffffff),
> +		PROPERTY_ENTRY_U64("u64_example", 0xffffffffffffffff),
> +		PROPERTY_ENTRY_STRING("string_example", "string"),
> +		{ }
> +	};
> +
> +Note! If "build-in" device properties are supplied to already existing device

            "built-in"

> +entries by using :c:func:`device_add_properties`, a software node is actually
> +created for that device. That software node is just assigned to the device
> +automatically in the function.
> +
> +Usage
> +=====
> +
> +Node creation
> +-------------
> +
> +Static nodes
> +~~~~~~~~~~~~
> +
> +In a normal case the software nodes are described statically with
> +:c:type:`struct software_node <software_node>`, and then registered with
> +:c:func:`software_node_register`. Usually there is more then one software node

                                                           than

> +that needs to be registered. A helper :c:func:`software_node_register_nodes`
> +registers a zero terminated array of software nodes::
> +
> +	static const struct property_entry props[] = {
> +		PROPERTY_ENTRY_STRING("foo", "bar"),
> +		{ }
> +	};
> +
> +	static const struct software_node my_nodes[] = {
> +		{ "grandparent" },		/* no parent nor properties */
> +		{ "parent", &my_nodes[0] },	/* parent, but no propreties */

		                                                  properties

> +		{ "child", &my_nodes[1], props }, /* parent and properties */
> +		{ }
> +	};
> +
> +	static int my_init(void)
> +	{
> +		return software_node_register_nodes(my_nodes);
> +	}
> +
> +Note! The above example names the nodes "grandparent", "parent" and "child", but
> +the software nodes don't actually have to be named. If no name is supplied for a
> +software node when it's being registered, the API names the node "node<n>" where
> +<n> is index number.
> +
> +Dynamic nodes
> +~~~~~~~~~~~~~
> +
> +The Quick (and dirty) method. A software node can be created on the fly with
> +:c:func:`fwnode_create_software_node`. The nodes create "on-the-fly" don't

                                                    created

> +differ from statically described software nodes in any way, but for now the API
> +does not support naming of these nodes::
> +
> +	static const struct property_entry my_props[] = {
> +		PROPERTY_ENTRY_STRING("foo", "bar"),
> +		{ }
> +	};
> +
> +	static int my_init(void)
> +	{
> +		struct fwnode_handle *fwnode;
> +
> +		/* Software node without a parent. */
> +		fwnode = fwnode_create_software_node(my_props, NULL);
> +		if (IS_ERR(fwnode))
> +			return PTR_ERR(fwnode);
> +
> +		return -1;
> +	}
> +
> +Linking software nodes with the device (struct device) entries
> +--------------------------------------------------------------
> +
> +Ideally the software node should be assigned to the device entry before the
> +device is registered (just like any other fwnode).
> +
> +When the software node is the primary fwnode for the device, the fwnode of the
> +device needs to simply point to the software node fwnode. Using a helper
> +:c:func:`software_node_fwnode` in the following example::
> +
> +	static const struct software_node my_node = {
> +		.name = "thenode",
> +	};
> +
> +	static int my_init(void)
> +	{
> +		struct device my_device = { };
> +		int ret;
> +
> +		ret = software_node_register(my_node);
> +		if (ret)
> +			return ret;
> +
> +		device_initialize(&my_device);
> +		dev_set_name(&my_device, "thedevice")
> +
> +		my_device.fwnode = software_node_fwnode(swnode);
> +
> +		return device_add(&my_device);
> +	}
> +
> +When the software node is the secondary fwnode for a device, i.e. the device has
> +either ACPI or DT (or something else) firmware node as the primary fwnode, the
> +node should be assigned with :c:func:`set_secondary_fwnode`. If the
> +``secondary`` member of the primary fwnode needs to be manually made to point
> +to the software node, the code needs to make sure that the ``secondary`` member
> +of the software node fwnode points to a specific value of ``ERR_PTR(-ENODEV)``::
> +
> +	struct fwnode_handle *fwnode = software_node_fwnode(swnode);
> +
> +	fwnode->secondary = ERR_PTR(-ENODEV);
> +	dev->fwnode->secondary = fwnode;
> +
> +Note! There is no requirement to bind a software node with a device entry, i.e.
> +having "sub-nodes" that represent for example certain resources the parent
> +software node has is not a problem.
> +
> +Node References
> +---------------
> +
> +TODO
> +
> +Device graph
> +------------
> +
> +TODO
> +
> +API
> +===
> +
> +.. kernel-doc:: include/linux/property.h
> +   :internal: software_node
> +
> +.. kernel-doc:: include/linux/fwnode.h
> +   :internal: fwnode_handle
> +
> +.. kernel-doc:: drivers/base/core.c
> +   :functions: set_secondary_fwnode
> +
> +.. kernel-doc:: drivers/base/swnode.c
> +   :functions: is_software_node is_software_node software_node_fwnode software_node_find_by_name software_node_register_nodes software_node_unregister_nodes software_node_register software_node_register fwnode_create_software_node fwnode_remove_software_node
> 

Thanks for the doc.
-- 
~Randy
