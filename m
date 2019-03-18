Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8D920811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfCRMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:47:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59444 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:47:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 9EE34268B3F
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Zach Reizner <zachr@google.com>,
        kernel@collabora.com, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jason Wang <jasowang@redhat.com>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
 <20180126135803.29781-2-tomeu.vizoso@collabora.com>
 <20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
 <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
Message-ID: <a777160f-5191-3808-7003-774df6d21f0e@collabora.com>
Date:   Mon, 18 Mar 2019 13:47:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Tomasz wants to comment, adding him to CC]

On 2/5/18 9:19 AM, Tomeu Vizoso wrote:
> On 1 February 2018 at 17:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Hi,
>>
>> Sorry for joining the party late. Had a broken finger and was
>> offline for a bunch of weeks (and a buif backlog afterwards ...).
> 
> Hi, no problem, hope it's fine now.
> 
>>> This is to allow clients running within VMs to be able to
>>> communicate with a compositor in the host. Clients will use the
>>> communication protocol that the compositor supports, and virtio-gpu
>>> will assist with making buffers available in both sides, and
>>> copying content as needed.
>>
>> Why not use virtio-vsock to run the wayland protocol? I don't like
>> the idea to duplicate something with very simliar functionality in 
>> virtio-gpu.
> 
> The reason for abandoning that approach was the type of objects that
> could be shared via virtio-vsock would be extremely limited. Besides
> that being potentially confusing to users, it would mean from the
> implementation side that either virtio-vsock would gain a dependency on
> the drm subsystem, or an appropriate abstraction for shareable buffers
> would need to be added for little gain.
> 
> Another factor that was taken into account was that the complexity
> required for implementing passing protocol data around was very small
> when compared with the buffer sharing mechanism.
> 
>>> It is expected that a service in the guest will act as a proxy, 
>>> interacting with virtio-gpu to support unmodified clients.
>>
>> If you have a guest proxy anyway using virtio-sock for the protocol 
>> stream and virtio-gpu for buffer sharing (and some day 3d rendering
>> too) should work fine I think.
> 
> If I understand correctly your proposal, virtio-gpu would be used for
> creating buffers that could be shared across domains, but something
> equivalent to SCM_RIGHTS would still be needed in virtio-vsock?
> 
> If so, that's what was planned initially, with the concern being that we
> would be adding a bunch of complexity to virtio-vsock that would be only
> used in this specific use case. Then we would also need to figure out
> how virtio-vsock would be able to work with buffers from virtio-gpu
> (either direct dependency or a new abstraction).
> 
> If the mechanics of passing presentation data were very complex, I think
> this approach would have more merit. But as you can see from the code,
> it isn't that bad.
> 
>>> When the client notifies the compositor that it can read from that
> buffer,
>>> the proxy should copy the contents from the SHM region to the
>>> virtio-gpu resource and call DRM_VIRTGPU_TRANSFER_TO_HOST.
>>
>> What is the plan for the host side? I see basically two options. Either 
>> implement the host wayland proxy directly in qemu. Or
>> implement it as separate process, which then needs some help from
>> qemu to get access to the buffers. The later would allow qemu running
>> independant from the desktop session.
> 
> Regarding synchronizing buffers, this will stop becoming needed in
> subsequent commits as all shared memory is allocated in the host and
> mapped to the guest via KVM_SET_USER_MEMORY_REGION.
> 
> This is already the case for buffers passed from the compositor to the
> clients (see patch 2/2), and I'm working on the equivalent for buffers
> from the guest to the host (clients still have to create buffers with
> DRM_VIRTGPU_RESOURCE_CREATE but they will be only backend by host memory
> so no calls to DRM_VIRTGPU_TRANSFER_TO_HOST are needed).
> 
> But in the case that we still need a proxy for some reason on the host
> side, I think it would be better to have it in the same process where
> virtio-gpu is implemented. In crosvm's case it would be in a process
> separate from the main VMM, as device processes are isolated from each
> other with minijail (see
> https://chromium.googlesource.com/chromiumos/platform/crosvm/ ).
> 
> Regards,
> 
> Tomeu
> 
