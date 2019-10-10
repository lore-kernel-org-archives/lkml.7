Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB927C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F98218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaP6/08j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbfJJJcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:32:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25846 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388027AbfJJJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570699948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/0XPqz4UbSzXqNBQ4Ow1dmSjgqzj/YZ0K/FLzFSFj8=;
        b=EaP6/08jWXg7xz4uXTaXEx5hEoRHnDfaA9LNnhPbrKF/pe9aMT/9OUZv3wDv5mTD3Q5TBH
        bMmjJcvCU+Pi56yBfKcKLx0bm99IQe6wT2KJul7fuJIJPoCpKOr+PkPSsCnHbCez3+FsKG
        2QgYNAr2gxmtKJWJ24uexFHnTTR5Gk0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-5a9YvdruP9GJkDhYZATzyw-1; Thu, 10 Oct 2019 05:32:27 -0400
Received: by mail-ed1-f71.google.com with SMTP id p55so3231406edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FyF419gdvItKDCVEO02AA/AvNq5Oq0Zq5xBcCsqWjLI=;
        b=qJIt6kzkA4gvSyOwNjgYD1b7mwhH+hjX9ze0nqrUWk6w+HZjWGF5g5EP/flPMHEV9n
         xm2riMtJzaHc44kBczOQZGb2KD46MYUHyi6e+XEeUmb9NTzxDlZR15uAwZVptrdUknOM
         sv5PNxp1pAjvQk7xLOCf1jxlMJrhnxIDKhMlpjuY4czD+oJ5bHlIolu7zb81yaUfuBwF
         o2scFb2saShNeUOQv/zmu3SsVL/ANt0LcAL+KBHR2l95S0eyu9208FiL4MpMw1p5GCj9
         PyxF3xgzHKBo4iYvBfEOz//Ws/NAHzeoxHqKSqxTFvrWcSpv4g9onZ78/tdTFKVfDV0/
         BKwQ==
X-Gm-Message-State: APjAAAXgxMZkKJrw4HfjMovBOO0nFqnCt5Y2V59yAzfpgk+WRQ2coRwC
        eYjIB++qfzUEPmJLpgIVSzE3KVmkqQUdA+A5MPZ8cyYhcta5oxlbw7rciOpS5RApznERoeUATF3
        DFuyAIdw8wZbmDS2aV2gt9f2E
X-Received: by 2002:a17:906:6dd3:: with SMTP id j19mr6998574ejt.144.1570699945455;
        Thu, 10 Oct 2019 02:32:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/iW1IsAGT9UA6UddG6Andm1MGHC3gYJRggjYmhupyXhYVLX87Hw/q8XSJFT3DTcEBGv6Y5w==
X-Received: by 2002:a17:906:6dd3:: with SMTP id j19mr6998550ejt.144.1570699945167;
        Thu, 10 Oct 2019 02:32:25 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id p19sm818317edq.31.2019.10.10.02.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 02:32:24 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] extcon: axp288: Move to swnodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20191008122600.22340-1-heikki.krogerus@linux.intel.com>
 <8120fbf2-08d3-6ee2-21bf-458a4e12b29c@redhat.com>
 <20191008140159.GC12909@kuha.fi.intel.com>
 <20191010083110.GA4981@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7730d466-53bc-c14a-120f-dcb91de1e973@redhat.com>
Date:   Thu, 10 Oct 2019 11:32:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010083110.GA4981@kuha.fi.intel.com>
Content-Language: en-US
X-MC-Unique: 5a9YvdruP9GJkDhYZATzyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-10-2019 10:31, Heikki Krogerus wrote:
> On Tue, Oct 08, 2019 at 05:02:04PM +0300, Heikki Krogerus wrote:
>> On Tue, Oct 08, 2019 at 03:59:23PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 08-10-2019 14:25, Heikki Krogerus wrote:
>>>> Hi Hans,
>>>>
>>>> Fixed the compiler warning in this version. No other changes.
>>>>
>>>> The original cover letter:
>>>>
>>>> That AXP288 extcon driver is the last that uses build-in connection
>>>> description. I'm replacing it with a code that finds the role mux
>>>> software node instead.
>>>>
>>>> I'm proposing also here a little helper
>>>> usb_role_switch_find_by_fwnode() that uses
>>>> class_find_device_by_fwnode() to find the role switches.
>>>
>>> Both patches look good to me and I can confirm that things still
>>> work as they should on a CHT device with an AXP288 PMIC, so for both:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>> p.s.
>>>
>>> I guess this means we can remove the build-in connection (
>>> device_connection_add / remove) stuff now?
>>
>> Yes. I'll prepare separate patches for that.
>=20
> Actually, maybe it would make sense to just remove it in this series.
> I'm attaching a patch that remove struct device_connection completely.
> Can you check if it makes sense to you?

This bit seems broken:

  static void *
  fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_i=
d,
                           void *data, devcon_match_fn_t match)
  {
-       struct device_connection con =3D { .id =3D con_id };
         struct fwnode_handle *ep;
         void *ret;

         fwnode_graph_for_each_endpoint(fwnode, ep) {
-               con.fwnode =3D fwnode_graph_get_remote_port_parent(ep);
-               if (!fwnode_device_is_available(con.fwnode))
+               fwnode =3D fwnode_graph_get_remote_port_parent(ep);

You are no replacing the passed in fwnode with the fwnode for the
remote_port_parent and then the next time through the loop you will
look at the wrong fwnode as the fwnode argument to
fwnode_graph_for_each_endpoint() gets evaluated multiple times:

#define fwnode_graph_for_each_endpoint(fwnode, child)                   \
         for (child =3D NULL;                                              =
\
              (child =3D fwnode_graph_get_next_endpoint(fwnode, child)); )

###

And there is a similar problem here, where you again use the fwmode
argument also as local variable in a loop where the function
argument should be evaluated more then once:

  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
                     void *data, devcon_match_fn_t match)
  {
-       struct device_connection con =3D { };
         void *ret;
         int i;

         for (i =3D 0; ; i++) {
-               con.fwnode =3D fwnode_find_reference(fwnode, con_id, i);
-               if (IS_ERR(con.fwnode))
+               fwnode =3D fwnode_find_reference(fwnode, con_id, i);

###

And it seems that this bit where you introduce -EPROBE_DEFER is an unrelate=
d
behavior change? :

+static void *generic_match(struct fwnode_handle *fwnode, const char *id,
+                          void *data)
  {
         struct bus_type *bus;
         struct device *dev;
+       void *ret =3D NULL;

         for (bus =3D generic_match_buses[0]; bus; bus++) {
-               dev =3D bus_find_device_by_fwnode(bus, con->fwnode);
-               if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)=
))
-                       return dev;
+               dev =3D bus_find_device_by_fwnode(bus, fwnode);
+               if (dev) {
+                       if (!strncmp(dev_name(dev), id, strlen(id)))
+                               return dev;
+                       ret =3D ERR_PTR(-EPROBE_DEFER);
+               }


Note that the old generic_match code had:

-       if (con->fwnode)
-               return device_connection_fwnode_match(con);

Which will simply always return either the dev or NULL, so as said this
is a behavior change AFAICT.

I've been trying to figure out what you are trying to do here and
I found a troublesome path through the old code:

1. device_connection_find() gets called on a device with a fwnode
2. device_connection_find() calls device_connection_find_match()
3. device_connection_find_match() calls fwnode_connection_find_match()
4. fwnode_connection_find_match() calls fwnode_graph_devcon_match() this re=
turns NULL
5. fwnode_connection_find_match() calls fwnode_devcon_match()
6. fwnode_devcon_match() creates a struct device_connection with just fwnod=
e set, the rest is 0/NULL
7. fwnode_devcon_match() calls generic_match() with this struct
8. generic_match() calls device_connection_fwnode_match() because con->fwno=
de is set
9. device_connection_fwnode_match() does the following if a device is found=
:
    if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
        return dev;
    but con->id is NULL here, so we have a NULL pointer deref here!

We are currently not hitting this path because there are no callers of
device_connection_find() all devcon users currently use device_connection_f=
ind_match()

Note I believe the code after your patch still has this problem. Also doing
the strcmp on the dev_name seems wrong? At least for the above code path, w=
here
fwnode_devcon_match() has already used / consumed the id.

So at a minimum we need to add a id =3D=3D NULL check to generic_match (*),=
 but
Since there are no users and the strcmp to to dev_name is weird, I believe =
that
it would be better to just remove device_connection_find() (and generic_mat=
ch, etc.) ?

This could be a preparation patch for the patch you attached, this would si=
mplify
this patch a bit.

###

If we end up with something like your suggested patch I think it might be g=
ood to
do a follow up where device_connection_find_match callers simply call
fwnode_connection_find_match directly and we remove device_connection_find_=
match ?
Or maybe turn it into a static inline function?

Regards,

Hans

*)  Note that the typec related callers of device_connection_find_match() a=
ll 3
either already have an id =3D=3D NULL check, or just ignore id completely.

